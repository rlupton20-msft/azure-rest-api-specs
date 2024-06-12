import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/userAuthentication.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@doc("Discovered Asset Endpoint Profile definition.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredAssetEndpointProfile
  is TrackedResource<DiscoveredAssetEndpointProfileProperties> {
  @doc("Discovered Asset Endpoint Profile name parameter.")
  @key("discoveredAssetEndpointProfileName")
  @segment("discoveredAssetEndpointProfiles")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Defines the Discovered Asset Endpoint Profile properties.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredAssetEndpointProfileProperties {
  @doc("The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.")
  targetAddress: url;

  @doc("Contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("List of supported authentication methods supported by the target server.")
  @extension("x-ms-identifiers", [])
  supportedAuthentications?: UserAuthenticationMode[];

  @doc("Defines the endpoint profile type.")
  endpointProfileType: string;

  @doc("Unique identifier used to detect changes in the discovered asset endpoint profile.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int32;

  @doc("The nodes identifiers on the Edge that host the brokers workload.")
  @extension("x-ms-identifiers", [])
  nodes?: string[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
interface DiscoveredAssetEndpointProfiles {
  get is ArmResourceRead<DiscoveredAssetEndpointProfile>;

  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAssetEndpointProfile>;

  update is ArmResourcePatchAsync<
    DiscoveredAssetEndpointProfile,
    DiscoveredAssetEndpointProfileProperties
  >;

  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAssetEndpointProfile>;

  listByResourceGroup is ArmResourceListByParent<DiscoveredAssetEndpointProfile>;

  listBySubscription is ArmListBySubscription<DiscoveredAssetEndpointProfile>;
}
