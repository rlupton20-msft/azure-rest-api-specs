import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/ns_discoveredAssetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@doc("Discovered asset definition.")
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@parentResource(Namespace)
model NamespaceDiscoveredAsset
  is TrackedResource<NamespaceDiscoveredAssetProperties> {
  @doc("Namespace Discovered Asset name parameter.")
  @key("discoveredAssetName")
  @segment("discoveredAssets")
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

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface NamespaceDiscoveredAssets {
  get is ArmResourceRead<NamespaceDiscoveredAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDiscoveredAsset>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    NamespaceDiscoveredAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDiscoveredAsset,
      NamespaceDiscoveredAssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDiscoveredAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDiscoveredAsset>;
}
