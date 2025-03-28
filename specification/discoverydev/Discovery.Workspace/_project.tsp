import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Azure.Discovery.Workspace.Versions)
namespace Azure.Discovery.Workspace;

@doc("A project.")
@resource("projects")
model Project {
  @doc("The project name.")
  @visibility(Lifecycle.Read)
  @key("projectName")
  name: string;
}

// TODO: Remove un-needed route prefix!
@route("/projects")
interface Projects {}
