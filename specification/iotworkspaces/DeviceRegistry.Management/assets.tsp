import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";
import "./common/assetProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;
@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@doc("Asset definition.")
model Asset is TrackedResource<AssetProperties> {
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
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@removed(Versions.v2024_10_01_preview)
@added(Versions.v2024_11_01)
@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Asset>;
  update is ArmCustomPatchAsync<
    Asset,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Asset,
      AssetProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;
  listByResourceGroup is ArmResourceListByParent<Asset>;
  listBySubscription is ArmListBySubscription<Asset>;
  @added(Versions.v2024_09_01_preview)
  @removed(Versions.v2024_10_01_preview)
  executeAction is ArmResourceActionAsync<
    Asset,
    Record<string>,
    Record<string>
  >;
}
