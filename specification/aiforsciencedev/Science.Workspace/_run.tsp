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

@doc("Status type.")
union RunStatus {
  /** Run Not started */
  NotStarted: "NotStarted",

  /** Run Committed */
  Running: "Running",

  /** Run Cancelled */
  Cancelled: "Cancelled",

  /** Run Success */
  Success: "Success",

  /** Run Failed */
  Failed: "Failed",

  string,
}

@doc("For URI of run result.")
model WithResultAsset {
  @doc("Data asset to which run results output will be written")
  @visibility("read")
  outputDataAssetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/dataAsset";
    }
  ]>;
}

@doc("A run.")
@resource("runs")
@parentResource(Investigation)
model Run {
  @doc("The run name.")
  @visibility("read")
  @key("runName")
  name: string;

  ...WithId;
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithStatusReason;
  ...WithRunMode;
  ...WithInvestigationInputs;
  ...WithYaml;
  ...WithStatus<RunStatus>;
  ...WithResultAsset;
}

interface Runs {
  @doc("Fetch a Run by name.")
  getRun is ResourceRead<Run>;

  //  @doc("Gets status of a Run operation.")
  //  getRunOperationStatus is GetResourceOperationStatus<Run>;

  //  @doc("Delete a Run asynchronously.")
  //  @pollingOperation(Runs.getRunOperationStatus)
  //  deleteRun is LongRunningResourceDelete<Run>;

  @doc("List Runs")
  listRuns is ResourceList<Run, QueryParametersTrait<WithQueryCreatedSince>>;

  @doc("Pause a run.")
  start is Operations.ResourceAction<Run, WithRunMode, Run>;

  @doc("Resume a paused run.")
  resume is Operations.ResourceAction<Run, {}, Run>;

  @doc("Cancel a run.")
  cancel is Operations.ResourceAction<Run, {}, Run>;

  @doc("Restore the Investigation Inputs and Plan to the state of this run.")
  restoreInvestigation is Operations.ResourceAction<Run, {}, Investigation>;
}
