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

@doc("A project.")
@resource("projects")
model Project {
  //  ...WithDescription;
  //  ...WithTags;
  //  ...WithCreatedAt;
  //  ...WithUpdatedAt;
  //  ...WithTitle;
  //  ...WithVertical;
  //
  @doc("The project name.")
  @visibility("read")
  @key("projectName")
  name: string;
  //
  //  @doc("Science Catalog artifacts available within Project.")
  //  @visibility("read", "create", "update")
  //  artifactIds: string[];
}

// TODO: Remove un-needed route prefix!
@route("/projects")
interface Projects {
  //  @doc("Fetch a Project by name.")
  //  getProject is ResourceRead<Project>;
  //
  //  @doc("Creates or replaces a Project.")
  //  createOrReplaceProject is StandardResourceOperations.ResourceCreateOrReplace<Project>;
  //
  //  @doc("Creates or updates a Project.")
  //  createOrUpdateProject is StandardResourceOperations.ResourceCreateOrUpdate<Project>;
  //
  //  @doc("List Project resources")
  //  listProjects is ResourceList<
  //    Project,
  //    QueryParametersTrait<WithQueryCreatedSince>
  //  >;
}
