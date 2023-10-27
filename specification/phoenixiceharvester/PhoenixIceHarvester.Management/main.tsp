import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.PhoenixIceHarvester")
@service({
  title: "Microsoft.PhoenixIceHarvester",
  version: "2023-08-22-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.PhoenixIceHarvester;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A Drill")
@parentResource(IceHarvester)
model Drill is ProxyResource<DrillProperties> {
  @doc("drill name")
  @key("drillName")
  @segment("drills")
  @visibility("read")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("The properties of Drill")
model DrillProperties {
  @doc("The drill's shape")
  @visibility("read")
  bitShape: string;

  @doc("Drill bit angle")
  bitAngle: int32;

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Drills {
  get is ArmResourceRead<Drill>;
  create is ArmResourceCreateOrUpdateSync<Drill>;
  delete is ArmResourceDeleteSync<Drill>;
  update is ArmResourcePatchSync<Drill, DrillProperties>;
  listByParent is ArmResourceListByParent<Drill>;
  listBySubscription is ArmListBySubscription<Drill>;
}

@doc("A IceHarvester")
model IceHarvester is TrackedResource<IceHarvesterProperties> {
  @doc("harvester name")
  @key("iceHarvesterName")
  @segment("iceHarvesters")
  @visibility("read")
  @path
  name: string;
}

@doc("The properties of IceHarvester")
model IceHarvesterProperties {
  @doc("The crater's location'")
  @visibility("read")
  craterLocation: string;

  @doc("size of ice")
  size: int32;

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface IceHarvesters {
  get is ArmResourceRead<IceHarvester>;
  create is ArmResourceCreateOrUpdateSync<IceHarvester>;
  delete is ArmResourceDeleteSync<IceHarvester>;
  update is ArmResourcePatchSync<IceHarvester, IceHarvesterProperties>;
  listByParent is ArmResourceListByParent<IceHarvester>;
  listBySubscription is ArmListBySubscription<IceHarvester>;
}
