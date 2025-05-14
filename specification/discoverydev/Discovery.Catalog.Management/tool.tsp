import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Tool tracked resource")
model Tool is TrackedResource<ToolProperties> {
  ...ResourceNameParameter<Tool>;
}

@doc("Discovery Tool properties")
model ToolProperties {
  @doc("Reference to tool definition.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  toolDefinitionId: string;

  @doc("The ARM resource ID of the model.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelId?: Microsoft.Discovery.Shared.ModelId;

  @doc("Tool definition YAML as a string.")
  @visibility(Lifecycle.Read)
  definitionContent?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Tools {
  get is ArmResourceRead<Tool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Tool>;
  update is ArmResourcePatchAsync<Tool, ToolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Tool>;
  listByResourceGroup is ArmResourceListByParent<Tool>;
  listBySubscription is ArmListBySubscription<Tool>;
}
