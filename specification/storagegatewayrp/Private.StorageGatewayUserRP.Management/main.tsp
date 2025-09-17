import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Private.StorageGatewayUserRP")
@service({
  title: "Private.StorageGatewayUserRP",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.StorageGatewayUserRP;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2025-03-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A StorageGatewayProviderHub resource")
model StorageGatewayModel is TrackedResource<StorageGatewayProperties> {
  @doc("The name of the storage gateway resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("storageGatewayName")
  @segment("storageGateways")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Resource creation Succeeded")
  Succeeded: "Succeeded",

  @doc("Resource creation Canceled")
  Canceled: "Canceled",

  @doc("Resource creation Failed")
  Failed: "Failed",

  @doc("Resource Deleting")
  Deleting: "Deleting",
}

@doc("Details of the StorageGateway.")
model StorageGatewayProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("The description of the StorageGateway resource.")
  description?: string;
}

@armResourceOperations(StorageGatewayModel)
interface StorageGateways {
  get is ArmResourceRead<StorageGatewayModel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageGatewayModel>;
  update is ArmResourcePatchSync<StorageGatewayModel, StorageGatewayProperties>;
  delete is ArmResourceDeleteSync<StorageGatewayModel>;
  listByResourceGroup is ArmResourceListByParent<StorageGatewayModel>;
  listBySubscription is ArmListBySubscription<StorageGatewayModel>;
}
