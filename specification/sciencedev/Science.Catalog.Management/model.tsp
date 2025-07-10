import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

// import "./project.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Science")
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Models tracked resource")
model Model is TrackedResource<ModelProperties> {
  ...ResourceNameParameter<Model>;
}

@doc("Model properties")
model ModelProperties {
  ...CatalogArtifactBaseProperties;

  @doc("The ARM resource ID of the subnet.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update) // TODO: Is it a resource identifier or just string? Please find example.
  // /subscriptions/.../resourceGroups/.../providers/Microsoft.Networks/virtualNetworks/{vnetName}/subnets/{subnetName}
  subnetId: Azure.Core.armResourceIdentifier;

  @doc("The deployment ID of the Model.")
  @visibility(Lifecycle.Read)
  modelDeploymentId?: string;

  @doc("The provisioning status of the Model.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Models {
  get is ArmResourceRead<Model>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Model>;
  update is ArmResourcePatchAsync<Model, ModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Model>;
  listByResourceGroup is ArmResourceListByParent<Model>;
  listBySubscription is ArmListBySubscription<Model>;
}
