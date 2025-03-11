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
   * Up to 10 files can be provided inline. This
   * is primarily intended for submitting agent-generated code.
   *
   * We impose a 10 file limit in order to place some bounds on how much
   * code can be submitted in this way. For submitting larger amounts of data,
   * a DataAsset should be used.
   *
   * It would be preferable to have a Record here with the relativePath as key, but
   * typespec doesn't allow @maxItems to be applied to a Record.
   */
  @doc("Encoded inline files to be mounted into the container, e.g. for generated code.")
  @maxItems(10)
  inlineFiles?: Array<InlineFile>;

  /*
   * All of the data referenced by these DataAssetIds is made available to the
   * tool container in a single input directory (the path to which is
   * provided to the container in the SC_TOOL_INPUT_DIR environment
   * variable):
   *
   *   - when multiple DataAssets are provided, the data from each DataAsset
   *   will be placed in a subdirectory within
   *   SC_TOOL_INPUT_DIR with the same name as the ID's key in this Record
   *
   *   - when only a single DataAsset with key "_" is provided,
   *   Supercomputer will put the data from that DataAsset in the
   *   top-level input directory
   */
  @doc("Input data assets to use for this execution.")
  inputDataAssets?: Record<DataAssetId>;

  /*
   * Note that this is an array, not a dictionary. Unlike inputs, a tool
   * only has one unit of output. There may be multiple DataAssets to
   * emit that data to, but each of these locations gets all the data.
   */
  @doc("Data assets to which to emit output of this execution")
  outputDataAssets?: DataAssetId[];

  @doc("IDs of NodePools to use for this execution. If not specified, suitable NodePools will be selected based on the infra requirements of the Tool.")
  nodePoolIds?: NodePoolId[];

  @doc("The shared storage to use for this execution.")
  sharedStorageId: StorageId;
}

@doc("A file to be included in the input data for a tool execution.")
model InlineFile {
  @doc("The relative path of the file within the input directory.")
  relativePath: string;

  /*
   * Limit the size of this field to ~20kB. This is a reasonable limit for
   * small code files, which are the primary use case for this feature.
   *
   * For reference, at the time of writing, iomanager.py was 7kB without
   * gzipping or encoding it.
   */
  @doc("base64-encoding of the gzipped contents of the file.")
  @maxLength(20000)
  encodedFile: string;
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
