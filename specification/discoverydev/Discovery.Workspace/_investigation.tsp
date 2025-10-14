import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using TypeSpec.Http;
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

@doc("Collection of data assets linked to an investigation.")
model InvestigationDataAssets {
  @doc("List of linked data asset IDs.")
  dataAssetIds: DataAssetId[];
}

@doc("Request body for linking a data asset to an investigation.")
model LinkDataAssetRequest {
  @doc("The data asset resource ID to link.")
  dataAssetId: DataAssetId;
}

@doc("Request body for unlinking a data asset from an investigation.")
model UnlinkDataAssetRequest {
  @doc("The data asset resource ID to unlink.")
  dataAssetId: DataAssetId;
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Start the cognitive loop for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}:startCognition")
  @post
  startCognitiveLoop is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    Investigation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Stop the cognitive loop for an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}:stopCognition")
  @post
  stopCognitiveLoop is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    Investigation
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get data assets linked to an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data")
  @get
  getInvestigationData is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;
    },
    InvestigationDataAssets
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Link a data asset to an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data:linkDataAsset")
  @post
  linkDataAsset is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The data asset link request.")
      @body
      body: LinkDataAssetRequest;
    },
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Unlink a data asset from an investigation.")
  @route("/projects/{projectName}/investigations/{investigationName}/data:unlinkDataAsset")
  @post
  unlinkDataAsset is Azure.Core.Foundations.Operation<
    {
      @doc("The project name.")
      @path
      @pattern(resourceNamePattern)
      projectName: string;

      @doc("The investigation name.")
      @path
      @pattern(resourceNamePattern)
      investigationName: string;

      @doc("The data asset unlink request.")
      @body
      body: UnlinkDataAssetRequest;
    },
    void
  >;
}
