import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";
import "./common/assetEndpointProfilesProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@doc("Asset Endpoint Profile definition.")
model AssetEndpointProfile is TrackedResource<AssetEndpointProfileProperties> {
  @doc("Asset Endpoint Profile name parameter.")
  @key("assetEndpointProfileName")
  @segment("assetEndpointProfiles")
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

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@armResourceOperations
interface AssetEndpointProfiles {
  get is ArmResourceRead<AssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AssetEndpointProfile>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    AssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      AssetEndpointProfile,
      AssetEndpointProfileProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<AssetEndpointProfile>;
  listBySubscription is ArmListBySubscription<AssetEndpointProfile>;

  @added(Versions.v2024_09_01_preview)
  @removed(Versions.v2024_10_01_preview)
  migrate is ArmResourceActionSync<
    AssetEndpointProfile,
    MigrateRequest,
    MigrateResponse
  >;
}
