import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

@doc("Status type.")
union RunStatus {
  /** Not started */
  NotStarted: "NotStarted",

  /** Paused */
  Paused: "Paused",

  /** Committed */
  Running: "Running",

  /** Success */
  Success: "Success",

  /** Failed */
  Failed: "Failed",

  string,
}

@doc("Step within a plan")
model Step {
  ...WithCreatedAt;
  ...WithUpdatedAt;

  @doc("The step name.")
  @visibility("read", "create")
  @key("stepName")
  name: string;

  @doc("The step order.")
  @visibility("read", "create", "update")
  stepNumber: int32;

  // TODO: What does actionId mean? I'm not clear how this differs from step name. Is this the same as "activityId" from run step?
  @doc("The step action ID.")
  @visibility("read", "create", "update")
  actionId: string;

  @doc("The ID of the associated Tool within Catalog.")
  @visibility("read", "create", "update")
  toolId: string;

  @doc("The step category.")
  @visibility("read", "create", "update")
  category: string;
}

@doc("A step within a run.")
model RunStep {
  ...Step;
  ...WithStatus<RunStatus>;
  ...WithStatusReason;
}

@doc("A run.")
@resource("runs")
@parentResource(Investigation)
model Run {
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithStatus<RunStatus>;
  ...WithStatusReason;
  ...WithRunMode;

  @doc("The run name.")
  @visibility("read")
  @key("runName")
  name: string;

  @doc("The ID of the associated Investigation Version")
  @visibility("read")
  investigationVersionId: string;
}

@doc("A run.")
@resource("runs")
@parentResource(Investigation)
model RunWithSteps {
  ...Run;

  @doc("Steps of the run.")
  @visibility("read")
  steps: RunStep[];
}

@doc("A run result.")
model RunResult {
  ...WithStatus<RunStatus>;
}

interface Runs {
  @doc("Fetch a Run by name.")
  getRun is ResourceRead<RunWithSteps>;

  //  @doc("Gets status of a Run operation.")
  //  getRunOperationStatus is GetResourceOperationStatus<Run>;

  //  @doc("Delete a Run asynchronously.")
  //  @pollingOperation(Runs.getRunOperationStatus)
  //  deleteRun is LongRunningResourceDelete<Run>;

  @doc("List Runs")
  listRuns is ResourceList<
    Run,
    QueryParametersTrait<WithQueryCreatedSince &
      WithQueryInvestigationVersionId>
  >;

  @doc("Pause a run.")
  pause is Operations.ResourceAction<Run, {}, {}>;

  @doc("Resume a paused run.")
  resume is Operations.ResourceAction<Run, {}, {}>;

  @doc("Cancel a run.")
  cancel is Operations.ResourceAction<Run, {}, {}>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  @get
  @route("/projects/{projectName}/investigations/{investigationName}/runs/{runName}/getResult")

  //    @route("/runs/{runName}/getResult")
  @doc("Get a run results.")
  getResult(
    //        @query
    //            /** API version */
    //            "api-version": string,

    /** Name of project */
    @path
    projectName: string,

    /** Name of investigation */
    investigationName: string,

    /** Name of run */
    runName: string,
  ): RunResult;
}
