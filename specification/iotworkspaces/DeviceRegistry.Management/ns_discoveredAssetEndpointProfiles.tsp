import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";
import "./common/discoveredAssetEndpointProfileProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@doc("Namespace Discovered Asset Endpoint Profile definition.")
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@parentResource(Namespace)
model NamespaceDiscoveredAssetEndpointProfile
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
interface NamespaceDiscoveredAssetEndpointProfiles {
  get is ArmResourceRead<NamespaceDiscoveredAssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredAssetEndpointProfile>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredAssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredAssetEndpointProfile,
      DiscoveredAssetEndpointProfileProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredAssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredAssetEndpointProfile>;
}
