import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Enum for storage sku")
union StorageSku {
  /** Standard Sku */
  Standard: "Standard",

  string,
}

@doc("Storage tracked resource")
model Storage is TrackedResource<StorageProperties> {
  ...ResourceNameParameter<Storage>;
}

@doc("Storage properties")
model StorageProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The ARM resource ID of the subnet. The subnetId should match the vnetId of supercomputers which will be used for running the tools that use the shared storage.")
  @visibility("read", "create", "update")
  // TODO: Is it a resource identifier or just string? Please find example.
  subnetId: Azure.Core.armResourceIdentifier;

  @doc("Sku.")
  @visibility("read", "create")
  // TODO: Study ARM sku.
  sku: StorageSku;

  // TODO: Add Mobo config
}

@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Storage>;
  update is ArmResourcePatchSync<Storage, StorageProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByResourceGroup is ArmResourceListByParent<Storage>;
  listBySubscription is ArmListBySubscription<Storage>;
}
