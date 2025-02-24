import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_run.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("Status")
union InvestigationStatus {
  /** Investigation Created */
  Created: "Created",

  /** Investigation Validated */
  Validated: "Validated",

  /** Investigation Failed */
  Failed: "Failed",

  string,
}

@doc("Run response.")
model RunResponse {
  /** The ID for the run. This enables tracking the run status. */
  runId: string;

  /** Run mode */
  runMode: RunMode;

  //  /** Step status list */
  //  stepStatusList: StepStatus[];
}

@doc("Input to an investigation")
model Input {
  @doc("The Data Asset ID")
  @visibility("read", "create", "update")
  dataAssetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/dataAsset";
    }
  ]>;

  ...WithCreatedAt;

  /** The properties derived from pre-processing the input */
  //  properties?: string[];
}

@doc("For tracking investigation inputs")
model WithInvestigationInputs {
  @doc("The inputs for the Investigation")
  @visibility("read", "create", "update")
  inputs?: Input[];
}

@doc("For timeout timestamp")
model WithTimeoutAt {
  @doc("The timeout timestamp")
  @visibility("read")
  timeoutAt: utcDateTime;
}

@doc("For run name")
model WithRunName {
  @doc("The name of the run containing the inputs and plan you wish to clone")
  @visibility("read", "create")
  runName?: string;
}

@access(Access.internal)
@doc("Common properties of investigation and investigation version.")
model InvestigationCore {
  ...WithId;
  ...WithDescription;
  ...WithTags;
  ...WithCreatedBy;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithTitle;
  ...WithInvestigationInputs;
}

@doc("A investigation list item.")
@resource("investigations")
@parentResource(Project)
model Investigation {
  @doc("The investigation name.")
  @visibility("read")
  @key("investigationName")
  name: string;

  ...InvestigationCore;
  ...WithStatus<InvestigationStatus>;

  /** Status of latest run */
  @visibility("read")
  latestRunStatus?: RunStatus;

  @doc("The ID of the user who locked the Investigation for editing, if any.")
  @visibility("read")
  lockedBy?: string;

  @doc("The timestamp when the investigation was locked")
  @visibility("read")
  lockedAt: utcDateTime;
}

@doc("A investigation.")
@resource("investigations")
@parentResource(Project)
model InvestigationWithYaml {
  ...Investigation;
  ...WithYaml;
}
@doc("Enumeration for run cache.")
union RunCacheMode {
  /** Cache run results */
  Cache: "Cache",

  /** Don't cache run results' */
  NoCache: "NoCache",

  string,
}

@doc("Run parameters.")
model RunParams {
  @doc("Data asset to which run results output will be written")
  @visibility("read", "create")
  outputDataAssetId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/dataAsset";
    }
  ]>;

  @doc("Caching behavior")
  @visibility("read", "create")
  cacheMode: RunCacheMode;
}

interface Investigations {
  @doc("Fetch a Investigation by name.")
  getInvestigation is ResourceRead<InvestigationWithYaml>;

  @doc("Gets status of a Investigation operation.")
  getInvestigationOperationStatus is GetResourceOperationStatus<Investigation>;

  @doc("Creates or replaces Investigation.")
  createOrReplaceInvestigation is StandardResourceOperations.ResourceCreateOrReplace<InvestigationWithYaml>;

  @doc("Creates or updates Investigation.")
  createOrUpdateInvestigation is StandardResourceOperations.ResourceCreateOrUpdate<InvestigationWithYaml>;

  @doc("Delete a Investigation.")
  deleteInvestigation is ResourceDelete<Investigation>;

  @doc("List Investigation resources")
  listInvestigations is ResourceList<
    Investigation,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  @doc("Validate an investigation.")
  @pollingOperation(Investigations.getInvestigationOperationStatus)
  // TODO: Return ValidationResponse
  validate is Operations.LongRunningResourceAction<
    Investigation,
    {},
    RequestIdResponseHeader
  >;

  @doc("Run an investigation.")
  createRun is Operations.ResourceAction<Investigation, RunParams, WithRunId>;

  //  @doc("Restore the Investigation to the state of this version.")
  //  restore is Operations.ResourceAction<InvestigationVersion, {}, Investigation>;

  //  @doc("Lock an investigation for editing.")
  //  lock is Operations.ResourceAction<Investigation, {}, WithTimeoutAt>;
  //
  //  @doc("Unlock an investigation for editing, restoring it to Draft status.")
  //  unlock is Operations.ResourceAction<Investigation, {}, {}>;

  //  @doc("Commit an investigation (to enable checkpoint).")
  //  createVersion is Operations.ResourceAction<Investigation, {}, WithVersionId>;

  @doc("Clone investigation (to a new one).")
  clone is Operations.ResourceAction<Investigation, WithRunName, Investigation>;

  //  @doc("Add an input.")
  //  addInput is Operations.ResourceAction<
  //    Investigation,
  //    {
  //      ...InputBase;
  //    },
  //    Input
  //  >;
  //
  //  @doc("Remove an input.")
  //  removeInput is Operations.ResourceAction<Investigation, WithInputName, Input>;
}
