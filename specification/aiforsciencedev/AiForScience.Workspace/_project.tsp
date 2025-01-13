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

@doc("A project.")
@resource("projects")
model Project {
  ...WithDescription;
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithTitle;

  @doc("The project name.")
  @visibility("read", "create")
  @key("projectName")
  name: string;
}

interface Projects {
  @doc("Fetch a Project by name.")
  getProject is ResourceRead<Project>;

  @doc("Creates or updates a Project asynchronously.")
  createOrUpdateProject is StandardResourceOperations.ResourceCreateOrUpdate<Project>;

  @doc("Delete a Project asynchronously.")
  deleteProject is ResourceDelete<Project>;

  @doc("List Project resources")
  listProjects is ResourceList<
    Project,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
