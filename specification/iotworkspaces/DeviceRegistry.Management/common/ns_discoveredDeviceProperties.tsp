import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./authenticationMethod.tsp";
import "./deviceProperties.tsp";

using TypeSpec.Versioning;

namespace Private.DeviceRegistry;

@doc("Defines the Discovered Asset Endpoint Profile properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDeviceProperties {
  @doc("A device id that represents the device in a system external to Azure. Unique within scope of an Azure Tenant.")
  externalDeviceId?: string;

  @doc("Endpoints for discovered devices.")
  endpoints?: DiscoveredMessagingEndpoints;

  @doc("Identifier used to detect changes in the asset endpoint profile.")
  discoveryId: string;

  @doc("Hardware manufacturer name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  manufacturer?: string;

  @doc("Model name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `model`?: string;

  @doc("Operating system name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystem?: string;

  @doc("Operating system version.")
  operatingSystemVersion?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes.")
  attributes?: Record<unknown>;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_07_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model DiscoveredMessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("An endpoint to connect with the device")
  inbound?: Record<DiscoveredInboundEndpoints>;

  @doc("Set of endpoints a device can connect to.")
  outbound?: DiscoveredOutboundEndpoints;
}

@doc("Property bag contains the device's outbound endpoints")
@added(Versions.v2025_07_01_preview)
model DiscoveredOutboundEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Endpoints the device can connect to.")
  assigned: Record<DeviceMessagingEndpoint>;
}

@doc("A type of endpoint to connect to the device.")
@added(Versions.v2025_07_01_preview)
model DiscoveredInboundEndpoints {
  @doc("Type of connection endpoint.")
  endpointType: string;

  @doc("Fully qualified domain name.")
  address: string;

  @doc("Protocol version associated with the endpoint e.g. 1 or 2 for endpointType Microsoft.HTTP, and 3.5 or 5.0 for endpointType Microsoft.Mqtt etc.")
  version?: string;

  @doc("List of supported authentication methods supported by device for Inbound connections.")
  supportedAuthenticationMethods?: AuthenticationMethod[];

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;
}
