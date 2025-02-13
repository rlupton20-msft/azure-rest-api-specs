import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;
@doc("Solution Dependency Context")
model SolutionDependencyContext {
  @doc("Solution Version Id")
  solutionVersionId?: string;

  @doc("Solution Template Id")
  solutionTemplateId?: string;

  @doc("Solution Template Version Id")
  solutionTemplateVersionId?: string;

  @doc("Target Id")
  targetId?: string;

  @doc("Solution dependencies")
  @extension("x-ms-identifiers", [])
  dependencies?: SolutionDependencyContext[];
}
