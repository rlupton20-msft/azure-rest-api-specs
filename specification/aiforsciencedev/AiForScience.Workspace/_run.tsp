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
  start is Operations.ResourceAction<Run, {}, {}>;

  @doc("Resume a paused run.")
  resume is Operations.ResourceAction<Run, {}, {}>;

  @doc("Cancel a run.")
  cancel is Operations.ResourceAction<Run, {}, {}>;

  @doc("Restore the Investigation Inputs and Plan to the state of this run.")
  restoreInvestigation is Operations.ResourceAction<Run, {}, Investigation>;

  //  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "mirrored API responds with a container"
  //  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  //  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  //  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "not yet versioned"
  //  @get
  //  @route("/projects/{projectName}/investigations/{investigationName}/runs/{runName}/getResult")
  //
  //  //    @route("/runs/{runName}/getResult")
  //  @doc("Get a run results.")
  //  getResult(
  //    //        @query
  //    //            /** API version */
  //    //            "api-version": string,
  //
  //    /** Name of project */
  //    @path
  //    projectName: string,
  //
  //    /** Name of investigation */
  //    investigationName: string,
  //
  //    /** Name of run */
  //    runName: string,
  //  ): RunResult;
}
