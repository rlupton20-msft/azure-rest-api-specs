import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

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

@doc("A investigation list item.")
@resource("investigations")
@parentResource(Project)
model Investigation {
  @doc("The investigation name.")
  @visibility(Lifecycle.Read)
  @key("investigationName")
  @pattern(resourceNamePattern)
  name: string;

  @doc("The parent project name.")
  @visibility(Lifecycle.Read)
  @pattern(resourceNamePattern)
  projectName: string;

  ...DataPlaneResource;
  ...WithStatus<InvestigationStatus>;
  ...WithDescription;
  ...WithTags;
  ...WithTitle;
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // TODO: Change to DataSet if/when available?
  outputDataAssetId: DataAssetId;

  @doc("Caching behavior")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  cacheMode: RunCacheMode;
}

interface Investigations {
  @doc("Fetch a Investigation by name.")
  getInvestigation is ResourceRead<Investigation>;

  @doc("Creates or updates Investigation.")
  createOrUpdateInvestigation is StandardResourceOperations.ResourceCreateOrUpdate<Investigation>;

  @doc("Delete a Investigation.")
  deleteInvestigation is ResourceDelete<Investigation>;

  @doc("List Investigation resources")
  listInvestigations is ResourceList<
    Investigation,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
