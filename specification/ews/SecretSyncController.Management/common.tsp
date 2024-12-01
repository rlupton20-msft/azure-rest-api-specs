import "@azure-tools/typespec-azure-resource-manager";
using Azure.ResourceManager;

@armProviderNamespace("Private.SecretSyncController")
namespace Private.SecretSyncController;

@doc("Provisioning state of the resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,
}
