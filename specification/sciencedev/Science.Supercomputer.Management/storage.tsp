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

@doc("Storage tracked resource")
model Storage is TrackedResource<StorageProperties> {
  ...ResourceNameParameter<Storage>;
  //   ...ResourceSkuProperty; // Adds sku: https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/data-types/
}

@doc("Storage properties")
model StorageProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The ARM resource ID of the subnet. The subnetId should match the vnetId of supercomputers which will be used for running the tools that use the shared storage.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update) // TODO: Is it a resource identifier or just string? Please find example.
  // /subscriptions/.../resourceGroups/.../providers/Microsoft.Networks/virtualNetworks/{vnetName}/subnets/{subnetName}
  subnetId: Azure.Core.armResourceIdentifier;

  ...MoboConfigurationWithMrg; // TODO: Do we need to limit ARM resource type(s)?

  // read
  @doc("The ID of the workspace.")
  @visibility(Lifecycle.Read)
  workspaceId?: WorkspaceId;
}

@armResourceOperations
interface Storages {
  get is ArmResourceRead<Storage>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Storage>;
  update is ArmResourcePatchAsync<Storage, StorageProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Storage>;
  listByResourceGroup is ArmResourceListByParent<Storage>;
  listBySubscription is ArmListBySubscription<Storage>;
}
