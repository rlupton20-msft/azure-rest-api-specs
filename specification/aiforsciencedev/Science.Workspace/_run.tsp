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

@doc("Status type.")
union RunStatus {
  /** Run Not started */
  NotStarted: "NotStarted",

  /** Run Paused */
  Paused: "Paused",

  /** Run Committed */
  Running: "Running",

  /** Run Success */
  Success: "Success",

  /** Run Failed */
  Failed: "Failed",

  string,
}

@doc("For URI of run result.")
model WithResultUri {
  @doc("URI where the result can be found.")
  @visibility("read")
  resultBlobUri: string;
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
  ...WithResultUri;

  //  @doc("The ID of the associated Investigation Version")
  //  @visibility("read")
  //  investigationVersionId: string;
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
  start is Operations.ResourceAction<Run, {}, Run>;

  @doc("Resume a paused run.")
  resume is Operations.ResourceAction<Run, {}, Run>;

  @doc("Cancel a run.")
  cancel is Operations.ResourceAction<Run, {}, Run>;

  @doc("Restore the Investigation Inputs and Plan to the state of this run.")
  restoreInvestigation is Operations.ResourceAction<Run, {}, Investigation>;
}
