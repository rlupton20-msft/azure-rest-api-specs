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

@armProviderNamespace("Microsoft.Science")
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("AiModels tracked resource")
model AiModel is TrackedResource<AiModelProperties> {
  ...ResourceNameParameter<AiModel>;
}

@doc("AiModel properties")
model AiModelProperties {
  @doc("The description of the AiModel.")
  @visibility("read", "create", "update")
  description: string;

  @doc("The unique identifier for the AiModel.")
  @visibility("read", "create")
  catalogModelReference: Artifact;

  @doc("The ARM resource ID of the subnet.")
  @visibility("read", "create", "update")
  subnetId: string; // TODO Make resource identifier

  @doc("The deployment ID of the AiModel.")
  @visibility("read")
  modelDeploymentId: string;

  @doc("The provisioning status of the AiModel.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AiModels {
  get is ArmResourceRead<AiModel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiModel>;
  update is ArmResourcePatchSync<AiModel, AiModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AiModel>;
  listByResourceGroup is ArmResourceListByParent<AiModel>;
  listBySubscription is ArmListBySubscription<AiModel>;
}
