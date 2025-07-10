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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

alias AssetPropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    AssetProperties,
    "defaultTopic"
  >>>;

  @added(Versions.v2024_07_01_preview)
  @removed(Versions.v2024_10_01_preview)
  @added(Versions.v2024_11_01)
  @doc("Object that describes the default topic information for the asset.")
  defaultTopic?: OptionalProperties<OmitDefaults<Topic>>;
};

@added(Versions.v2024_09_01_preview)
@removed(Versions.v2024_10_01_preview)
@doc("Asset Migrate request properties.")
model MigrateRequest {
  @doc("The resource id of the namespace to migrate Asset into.")
  @pattern("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Private\\.DeviceRegistry/namespaces/[^/]+$")
  namespaceId: string;
}

@added(Versions.v2024_09_01_preview)
@removed(Versions.v2024_10_01_preview)
@doc("Asset Migrate response properties.")
model MigrateResponse {
  @doc("The resource id of the migrated Asset.")
  @visibility(Lifecycle.Read)
  resourceId: string;
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
      AssetPropertiesUpdate
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

  @added(Versions.v2024_09_01_preview)
  @removed(Versions.v2024_10_01_preview)
  migrate is ArmResourceActionSync<Asset, MigrateRequest, MigrateResponse>;
}
