import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Asset Endpoint Profile definition.")
@removed(Versions.v2024_10_01_preview)
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
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
@removed(Versions.v2024_10_01_preview)
interface AssetEndpointProfiles {
  get is ArmResourceRead<AssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AssetEndpointProfile>;
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
}
