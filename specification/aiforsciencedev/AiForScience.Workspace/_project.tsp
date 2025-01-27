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

/** Enum for including or excluding items */
union InclusionBehavior {
  /** Include */
  Include: "Include",

  /** Exclude */
  Exclude: "Exclude",

  string,
}

@doc("Settings for configuring Science Catalog artifact availability.")
model ArtifactConfiguration {
  @doc("ID of the AiForScience Catalog data plane resource.")
  @visibility("read", "create", "update")
  id: string;

  @doc("Whether to include or exclude the artifact")
  @visibility("read", "create", "update")
  inclusionBehavior: InclusionBehavior;
}

@doc("Enumeration for vertical.")
union Vertical {
  /** Chemistry */
  Chemistry: "Chemistry",

  /** Biology */
  Biology: "Biology",

  /** Physics */
  Physics: "Physics",

  /** Silicon */
  Silicon: "Silicon",

  string,
}

@doc("Settings for configuring associated Science Catalog artifact verticals.")
model WithVertical {
  @doc("Property for configuring associated verticals.")
  @visibility("read", "create", "update")
  vertical: Vertical;
}

@doc("A project.")
@resource("projects")
model Project {
  ...WithDescription;
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithTitle;
  ...WithVertical;

  @doc("The project name.")
  @visibility("read", "create")
  @key("projectName")
  name: string;

  @doc("Settings for configuring Science Catalog tool availability.")
  @visibility("read", "create", "update")
  toolSettings: ArtifactConfiguration[];

  @doc("Settings for configuring Science Catalog Knowledge Base availability.")
  @visibility("read", "create", "update")
  knowledgeBaseSettings: ArtifactConfiguration[];

  @doc("Settings for configuring Science Catalog Data Asset availability.")
  @visibility("read", "create", "update")
  dataAssetSettings: ArtifactConfiguration[];
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Projects {
  @doc("Fetch a Project by name.")
  getProject is ResourceRead<Project>;

  @doc("Creates or updates a Project asynchronously.")
  createOrUpdateProject is StandardResourceOperations.ResourceCreateOrUpdate<Project>;

  @doc("List Project resources")
  listProjects is ResourceList<
    Project,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
