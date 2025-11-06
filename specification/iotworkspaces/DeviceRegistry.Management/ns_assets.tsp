import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespaces.tsp";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./common/ns_assetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("NamespaceAsset definition.")
@parentResource(Namespace)
model NamespaceAsset is TrackedResource<NamespaceAssetProperties> {
  @doc("Asset name parameter.")
  @key("assetName")
  @segment("assets")
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
interface NamespaceAssets {
  get is ArmResourceRead<NamespaceAsset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceAsset>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    NamespaceAsset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceAsset,
      NamespaceAssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceAsset>;
  listByResourceGroup is ArmResourceListByParent<NamespaceAsset>;
}
