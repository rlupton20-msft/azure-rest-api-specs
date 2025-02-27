import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("A Microsoft.AiForScience tool resource.")
@resource("Tools")
model Tool {
  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;
}

@doc("Parameter model for executions")
model Parameter {
  @doc("The name of the parameter.")
  name: string;

  @doc("The value of the parameter.")
  value: string;
}

@doc("An execution of aTool")
model ExecutionRequest {
  @doc("The action ID, as defined in the tool's resource definition.")
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
   *     each handle will be placed within the same SC_TOOL_INPUT_DIR
   *     replicating the folder structure of linked handle.
   */
  inputHandles?: Array<LinkedDataSets>;

  /**
   * On the request, this specifies locations to the SharedStorage also represented as Datasets
   * and or others datasets to write output to.
   * Any data which the tool writes to the directory specified by SC_TOOL_OUTPUT_DIR is written
   * to the default SharedStorage location, and any additional
   * locations specified in this array.
   */
  outputHandles?: Array<LinkedDataSets>;

  @doc("IDs of NodePools to use for this execution.")
  nodePoolIds: Array<LinkedNodePools>;

  @doc("The shared storage which would be mounted on the nodepools and made available for the tool to use for this execution.")
  sharedStorage: LinkedStorage;
}

@doc("Tool execution ID")
model WithExecutionId {
  @doc("Execution ID")
  @key("executionId")
  @visibility("query")
  executionId: string;
}

@doc("Tools runtime execution state")
union RunTimeState {
  /** Tool execution has not started yet */
  Pending: "Pending",

  /** Tool is Running */
  Running: "Running",

  /** Tool has successfully run */
  Succeeded: "Succeeded",

  /** Tool run has Failed */
  Failed: "Failed",

  /** Tool run is Cancelled */
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

interface Tools {
  getExecutionStatus is Operations.GetResourceOperationStatus<
    Tool,
    ExecutionStatus
  >;

  @doc("Start indexing.")
  @pollingOperation(Tools.getExecutionStatus)
  execute is Operations.LongRunningResourceAction<
    Tool,
    ExecutionRequest,
    ExecutionStatus
  >;
}
