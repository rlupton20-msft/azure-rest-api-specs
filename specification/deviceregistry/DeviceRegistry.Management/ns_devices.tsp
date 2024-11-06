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
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@parentResource(Namespace)
@doc("Device Model as ARM resource.")
model NamespaceDevice is TrackedResource<DeviceProperties_V2024_10_01_Preview> {
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
  @visibility("read")
  etag?: string;
}

@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model DeviceMessagingEndpoint {
  @doc("Type of connection used for the endpoint.")
  type?: string;
}

@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model MessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Actively used endpoints a device can use to connect to several services.")
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("List of most recently removed endpoints.")
  unassigned?: Record<DeviceMessagingEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface NamespaceDevices {
  get is ArmResourceRead<NamespaceDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDevice>;
  update is ArmResourcePatchAsync<
    NamespaceDevice,
    DeviceProperties_V2024_10_01_Preview
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDevice>;
  listBySubscription is ArmListBySubscription<NamespaceDevice>;
}
