import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./namespaces.tsp";
import "./common/topic.tsp";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/authenticationMethod.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@parentResource(Namespace)
@doc("Namespace Asset Endpoint Profile definition.")
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
model NamespaceAssetEndpointProfile
  is TrackedResource<AssetEndpointProfileProperties> {
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

alias NamespaceAssetEndpointProfilePropertiesUpdate = {
  ...OptionalProperties<UpdateableProperties<OmitProperties<
    AssetEndpointProfileProperties,
    "authentication"
  >>>;

  @added(Versions.v2024_10_01_preview)
  @removed(Versions.v2024_11_01)
  @doc("Object that describes the default user authentication information for the asset endpoint profile.")
  authentication?: OptionalProperties<OmitDefaults<Authentication>>;
};

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@armResourceOperations
interface NamespaceAssetEndpointProfiles {
  get is ArmResourceRead<NamespaceAssetEndpointProfile>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceAssetEndpointProfile>;
  update is ArmCustomPatchAsync<
    NamespaceAssetEndpointProfile,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceAssetEndpointProfile,
      NamespaceAssetEndpointProfilePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceAssetEndpointProfile>;
  listByResourceGroup is ArmResourceListByParent<NamespaceAssetEndpointProfile>;
}
