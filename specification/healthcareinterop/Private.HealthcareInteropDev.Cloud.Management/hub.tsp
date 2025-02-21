import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop hub resource.")
model Hub is TrackedResource<HubProperties> {
  @doc("The name of the hub resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hubName")
  @segment("hubs")
  @path
  name: string;
}

@doc("Hub properties")
model HubProperties {
  @doc("Name to be used for the managed resource group that will be created.")
  @visibility("create", "read")
  managedResourceGroupName: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Hubs {
  get is ArmResourceRead<Hub>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hub>;
  update is ArmResourcePatchAsync<Hub, HubProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hub>;
  listByResourceGroup is ArmResourceListByParent<Hub>;
  listBySubscription is ArmListBySubscription<Hub>;
}
