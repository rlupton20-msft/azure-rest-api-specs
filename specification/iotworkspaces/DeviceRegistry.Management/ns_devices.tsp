import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/deviceProperties.tsp";
import "./common/extendedLocation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@parentResource(Namespace)
@doc("Device Model as ARM resource.")
model NamespaceDevice is TrackedResource<NamespaceDeviceProperties> {
  @doc("Name of the device.")
  @key("deviceName")
  @segment("devices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_07_01_preview)
  extendedLocation?: ExtendedLocation;
}

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface NamespaceDevices {
  get is ArmResourceRead<NamespaceDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDevice>;
  @patch(#{ implicitOptionality: true })
  update is ArmResourcePatchAsync<NamespaceDevice, NamespaceDeviceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDevice>;
}
