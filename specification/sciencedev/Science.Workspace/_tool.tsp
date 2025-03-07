import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "../Science.Catalog.Management/common.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("A Scientific tool.")
@resource("tools")
model Tool {
  /*
   * Note that this model exists purely to provide a data plane "resource" to submit
   * executions to. There are no data plane CRUD operations on the Tool resource because
   * these are done via the control plane. The data plane exists purely for tool execution.
   */
  @doc("The scientific tool name.")
  @visibility(Lifecycle.Read)
  @key("toolName")
  name: string;
}

@doc("An execution of a Tool")
model ExecutionRequest {
  @doc("Command to pass to tool container's entrypoint. If omitted, entrypoint is executed.")
  command?: string;

  /*
   * All of the data referenced by these handles is made available to the
   * tool container in a single input directory (the path to which is
   * provided to the container in the SC_TOOL_INPUT_DIR environment
   * variable):
   *
   *   - when multiple input handles are provided, the data referenced by
   *   each handle will be placed in a subdirectory within
   *   SC_TOOL_INPUT_DIR with the same name as the handle's key
   *
   *   - when only a single input handle with key "_" is provided,
   *   Supercomputer will put the data referenced by that handle in the
   *   top-level input directory
   */
  @doc("Handles to the input data to use for this execution.")
  inputHandles?: Record<DataHandle>;

  /*
   * On the request, this specifies locations *in addition to* the
   * default SharedStorage to write output to. Any data which the tool
   * writes to the directory specified by SC_TOOL_OUTPUT_DIR is written
   * to the default SharedStorage location, and any *additional*
   * locations specified in this array.
   *
   * On the response, this includes handles to all locations where output
   * was written, *including* the default SharedStorage.
   *
   * Note that this is an array, not a dictionary. Unlike inputs, a tool
   * only has one opaque blob of output. There may be multiple handles to
   * that output data (e.g. SharedStorage + one or more DataAssets), but
   * each of these locations gets all the data.
   *
   */
  @doc("Handles to the output locations for this execution")
  outputHandles?: DataHandle[];

  @doc("IDs of NodePools to use for this execution.")
  nodePoolIds: NodePoolId[];

  @doc("The shared storage to use for this execution.")
  sharedStorageId: StorageId;
}

@doc("A file to be included in the input data for a tool execution.")
model InlineFile {
  @doc("The relative path of the file within the input directory.")
  relativePath: string;

  /*
   * Limit the size of the file to ~20kB. This is a reasonable limit for
   * small code files, which are the primary use case for this feature.
   *
   * For reference, at the time of writing, iomanager.py was 7kB.
   */
  @doc("The base64-encoded contents of the file.")
  @maxLength(20000)
  encodedFile: string;
}

/** Enum for IndexingStatus */
union HandleType {
  /** Catalog DataAsset */
  DataAsset: "DataAsset",

  /** Inline files */
  InlineFiles: "InlineFiles",

  /** BlobStorage */
  // TODO: Remove post M1.
  BlobStorage: "BlobStorage",

  string,
}

@doc("A Data handle referring to an input or output of a execution")
model DataHandle {
  @doc("The type of the input handle.")
  handleType: HandleType;

  @doc("Location of the input data.")
  /*
   * For DataAsset handles, this is the ARM ID of a DataAsset.
   * If a DataAsset is e.g. a storage container, all of the storage container will be made
   * available to the tool. If it is a single blob, just that file will be
   * made available. It is up to the user/Copilot to create the right DataAssets.
   *
   * For BlobStorage handles, this is a URL which specifies either a
   * storage container, a specific blob or a prefix which matches
   * potentially multiple blobs. This is here as a convenience to allow
   * integration with Copilot before DataAssets are implemented.
   *
   */
  location: string;

  /*
   * For InlineFiles handles, up to 10 files can be provided inline. This
   * is primarily intended for submitting agent-generated code.
   *
   * We impose a 10 file limit in order to place some bounds on how much
   * code can be submitted in this way. For submitting larger amounts of data,
   * a DataAsset should be used.
   *
   * It would be preferable to have a Record here with the relativePath as key, but
   * typespec doesn't allow @maxItems to be applied to a Record.
   */
  @doc("Encoded inline files. Required, and only valid, if handleType is InlineFiles.")
  @maxItems(10)
  files?: Array<InlineFile>;
}

@doc("Execution status model")
model ExecutionStatusResult {
  @doc("Human-readable details about the execution status.")
  runtimeDetails: string;

  @doc("The time the execution was created.")
  createdTime: utcDateTime;

  @doc("The time the execution completed.")
  completedTime?: utcDateTime;

  @doc("Details provided by the tool (rather than the platform).")
  toolReport?: {
    estimatedCompletionTime?: utcDateTime;
    statusInformation?: {};
  };

  /*
   * The intention is to place the original request payload in this field as
   * an escaped JSON string. We do this instead of making this model an extension
   * of ExecutionRequest to avoid consumers taking a hard dependency on this
   * information being present.
   */
  @doc("Debugging information.")
  debugInfo: string;
}

interface Tools {
  @doc("Used for to poll status of a Tool execution.")
  getExecutionStatus is Operations.GetResourceOperationStatus<
    Tool,
    ExecutionStatusResult
  >;

  @doc("Execute a Tool.")
  @pollingOperation(Tools.getExecutionStatus)
  execute is Operations.LongRunningResourceAction<
    Tool,
    ExecutionRequest,
    ExecutionStatusResult
  >;
}
