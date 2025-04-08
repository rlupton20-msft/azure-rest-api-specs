import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

// import "./project.tsp";
import "./common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Tool tracked resource")
model Tool is TrackedResource<ToolProperties> {
  ...ResourceNameParameter<Tool>;
}

@doc("Science Tool properties")
model ToolProperties {
  ...CatalogArtifactBaseProperties;

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
