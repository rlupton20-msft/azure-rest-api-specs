import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";
import "./common/discoveredDeviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@doc("Discovered device definition.")
@added(Versions.v2025_07_01_preview)
model DiscoveredDevice is TrackedResource<DiscoveredDeviceProperties> {
  @doc("Discovered device name parameter.")
  @key("discoveredDeviceName")
  @segment("discoveredDevices")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2025_07_01_preview)
interface DiscoveredDevices {
  get is ArmResourceRead<DiscoveredDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredDevice>;
  update is ArmCustomPatchAsync<
    DiscoveredDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      DiscoveredDevice,
      DiscoveredDeviceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredDevice>;
  listByResourceGroup is ArmResourceListByParent<DiscoveredDevice>;
  listBySubscription is ArmListBySubscription<DiscoveredDevice>;
}
