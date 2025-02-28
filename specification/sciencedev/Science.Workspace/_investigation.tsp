import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
//import "./_run.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

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
}

@doc("For timeout timestamp")
model WithTimeoutAt {
  @doc("The timeout timestamp")
  @visibility("read")
  timeoutAt: utcDateTime;
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
      type: "Microsoft.Science/dataAsset";
    }
  ]>;

  @doc("Caching behavior")
  @visibility("read", "create")
  cacheMode: RunCacheMode;
}

interface Investigations {
  @doc("Fetch a Investigation by name.")
  getInvestigation is ResourceRead<Investigation>;

  @doc("Gets status of a Investigation operation.")
  getInvestigationOperationStatus is GetResourceOperationStatus<Investigation>;

  @doc("Creates or replaces Investigation.")
  createOrReplaceInvestigation is StandardResourceOperations.ResourceCreateOrReplace<Investigation>;

  @doc("Creates or updates Investigation.")
  createOrUpdateInvestigation is StandardResourceOperations.ResourceCreateOrUpdate<Investigation>;

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

  @doc("Clone investigation (to a new one).")
  clone is Operations.ResourceAction<Investigation, {}, Investigation>;
}
