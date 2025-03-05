import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/**
  For models needed by Tool in both data plane and control plane
  and avoiding naming conflicts.
 */
@doc("Science Tool base properties")
// @access(Access.internal)
model ToolBaseProperties {
  // Can't have provisioningState here due to issues overlapping control plane a nd data plane code (versioned common Azure packages)
  //    @doc("The status of the last operation.")
  //    @visibility(Lifecycle.Read)
  //    provisioningState?: ProvisioningState;

  @doc("Tool description used for copilot prompt and execution.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  description: string;

  @doc("Reference to catalog tool definition.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  toolDefinitionId: string;
}
