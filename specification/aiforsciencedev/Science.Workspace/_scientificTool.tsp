import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("A Scientific tool.")
@resource("scientificTools")
model ScientificTool {
  @doc("The scientific tool name.")
  @visibility("read")
  @key("toolName")
  name: string;
}

@doc("An execution of a ScientificTool")
model ExecutionRequest {
  @doc("The action ID, as defined in the tool's Catalog definition.")
  actionId: string;

  @doc("The parameters of the execution.")
  parameters?: Parameter[];

  @doc("Handles to the input data to use for this execution.")
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
   *
   */
  inputHandles?: Record<DataHandle>;

  /**
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
  nodePoolIds: ResourceReference[];

  @doc("The shared storage to use for this execution.")
  sharedStorage: ResourceReference;
}

/** Enum for IndexingStatus */
union HandleType {
  /** SharedStorage */
  SharedStorage: "SharedStorage",

  /** Catalog DataAsset */
  DataAsset: "DataAsset",

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
   * For SharedStorage handles, this is of the form <sharedStorageName>/<handle>
   * - <handle> is an opaque handle which Supercomputer knows how to map
   * to an actual filesystem location.
   *
   * For DataAsset handles, this is of the form
   * <catalogName>/<dataAssetName>. DataAssets refer to a meaningful
   * units of data, so there's no mechanism to refer to a specific subset
   * of a DataAsset (e.g. an individual file). If a DataAsset is e.g. a
   * storage container, all of the storage container will be made
   * available to the tool. If it is a single blob, just that file will be
   * made available. It is up to the user/Copilot to create the right DataAssets.
   *
   * For BlobStorage handles, this is a URL which specifies either a
   * storage container, a specific blob or a prefix which matches
   * potentially multiple blobs. This is here as a convenience to allow
   * integration with Copilot before DataAssets are implemented.
   *
   * Open question: For tools that output a single file, how is DataAsset defined before data actually exists?
   *     - assume for now that DataAsset can point to non-existent data
   *     (or that an output DataAsset must always point to a
   *     "container-like" object such as a storage container, rather than
   *     a "file-like" object such as a blob URL).
   */
  location: string;
}

@doc("Parameter model for executions")
model Parameter {
  @doc("The name of the parameter.")
  name: string;

  @doc("The value of the parameter.")
  value: string;
}

@doc("Tool execution ID")
model WithExecutionId {
  @doc("Execution ID")
  @key("executionId")
  @visibility("query")
  executionId: string;
}

/** Enum for IndexingStatus */
union RunTimeState {
  /** Pending */
  Pending: "Pending",

  /** Running */
  Running: "Running",

  /** Succeeded */
  Succeeded: "Succeeded",

  /** Failed */
  Failed: "Failed",

  /** Cancelled */
  Cancelled: "Cancelled",

  string,
}

@doc("Execution status model")
model ExecutionStatus {
  ...WithExecutionId;

  @doc("The runtime state of the execution.")
  runtimeState: RunTimeState;

  @doc("Human-readable details about the execution status.")
  runtimeDetails: string;

  @doc("The time the execution was created.")
  createdTime: utcDateTime;

  @doc("The time the execution completed.")
  completedTime?: utcDateTime;

  @doc("Error details if the execution failed.")
  errorDetails?: string[];

  @doc("Details provided by the tool (rather than the platform).")
  toolReport?: {
    estimatedCompletionTime?: utcDateTime;
    statusInformation?: {};
  };
}

interface ScientificTools {
  getExecutionStatus is Operations.GetResourceOperationStatus<
    ScientificTool,
    ExecutionStatus
  >;

  @doc("Start indexing.")
  @pollingOperation(ScientificTools.getExecutionStatus)
  execute is Operations.LongRunningResourceAction<
    ScientificTool,
    ExecutionRequest,
    ExecutionStatus
  >;
}
