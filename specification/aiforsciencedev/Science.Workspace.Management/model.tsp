import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./project.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AiForScience")
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Models tracked resource")
model Model is TrackedResource<ModelProperties> {
  ...ResourceNameParameter<Model>;
}

@doc("Model properties")
model ModelProperties {
  @doc("The description of the Model.")
  @visibility("read", "create", "update")
  description: string;

  @doc("The unique identifier for the Model.")
  @visibility("read", "create")
  // TODO: Include "definition" in property name?
  catalogModelId: string;

  @doc("The ARM resource ID of the subnet.")
  @visibility("read", "create", "update")
  // TODO: Is it a resource identifier or just string? Please find example.
  // /subscriptions/.../resourceGroups/.../providers/Microsoft.Networks/virtualNetworks/{vnetName}/subnets/{subnetName}
  subnetId: Azure.Core.armResourceIdentifier;

  @doc("The deployment ID of the Model.")
  @visibility("read")
  modelDeploymentId: string;

  @doc("The provisioning status of the Model.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Models {
  get is ArmResourceRead<Model>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Model>;
  update is ArmResourcePatchSync<Model, ModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Model>;
  listByResourceGroup is ArmResourceListByParent<Model>;
  listBySubscription is ArmListBySubscription<Model>;
}
