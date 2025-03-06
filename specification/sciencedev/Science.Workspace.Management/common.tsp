import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

/**
  For models needed by Tool in both data plane and control plane
  and avoiding naming conflicts.
 */
@doc("Science Tool base properties")
@access(Access.internal)
model CatalogArtifactBaseProperties {
  @doc("Reference to catalog definition.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  catalogDefinitionId: string;

  @doc("Tool description used for copilot prompt and execution.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description: string;
}
