import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/deviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;

@removed(Versions.v2024_10_01_preview)
@doc("Device Model as ARM resource.")
model Device is TrackedResource<DeviceProperties> {
  @doc("Name of the device.")
  @key("deviceName")
  @segment("devices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@removed(Versions.v2024_10_01_preview)
@armResourceOperations
interface Devices {
  get is ArmResourceRead<Device>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Device>;
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    Device,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Device,
      DeviceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Device>;
  listByResourceGroup is ArmResourceListByParent<Device>;
  listBySubscription is ArmListBySubscription<Device>;
}
