import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common-types.tsp";
import "./chambers.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@service({
  title: "ModSimWorkbench Control Plane API",
  version: "2021-03-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.DevModSimWorkbench;

@doc("Performace tier of shared storage.")
enum SharedStoragePerformaceTier {
  @doc("Standard tier.")
  Standard,

  @doc("Ultra tier.")
  Ultra,
}

@doc("List of chambers connected to a shared storage.")
model ConnectedChamber {
  @doc("Fully qualified resource ID for the chamber resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id: string; // TODO: Change to chamberId
}

@doc("Shared storage properties.")
model SharedStorageProperties {
  ...ProvisioningStateProperty;
  ...CapacityAllocatedProperty;
  ...CapacityUsedProperty;

  @visibility("read", "create")
  @doc("Directory where the shared storage volume mounted.")
  localMountPath?: string;

  @visibility("read", "create", "update")
  @doc("Performance tier of the shared storage.")
  performanceTier: SharedStoragePerformaceTier = SharedStoragePerformaceTier.Standard;

  @visibility("read", "create", "update")
  @doc("List of Chambers connected to the shared storage.")
  chambers: Array<ConnectedChamber>;
}

@doc("Shared storage tracked resource.")
@parentResource(Workbench)
model SharedStorage is TrackedResource<SharedStorageProperties> {
  @doc("The name of the shared storage")
  @segment("sharedStorages")
  @key("sharedStorageName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

@armResourceOperations
interface SharedStorages
  extends NestedResource<SharedStorage, SharedStorageProperties> {}
