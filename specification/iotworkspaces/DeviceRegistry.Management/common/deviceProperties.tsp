import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";
import "./sharedDeviceProperties.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using OpenAPI;

namespace Private.DeviceRegistry;
@doc("Defines the device base properties.")
model DeviceBaseProperties {
  @doc("Gets a unique identifier for this resource.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with AAD.")
  enabled?: boolean = true;

  @doc("Gets the device Id provided by customer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  @doc("Device Template Id used to create a device.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceTemplateId?: string;

  @doc("The AAD group the device is a member of.")
  deviceGroupId?: string;

  @doc("Hardware manufacturer name.")
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  @doc("Hardware model name.")
  @visibility(Lifecycle.Read)
  `model`?: string;

  @doc("operating system name.")
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  @doc("operating system version.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystemVersion?: string;

  @doc("Identity for the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: DeviceIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Device status updates.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  status?: DeviceStatus;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@doc("Defines the device properties.")
model DeviceProperties extends DeviceBaseProperties {
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: DeviceEndpoints;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("Defines the device properties.")
@renamedFrom(
  Versions.v2025_07_01_preview,
  "DeviceProperties_V2024_10_01_Preview"
)
model EdgeCapableDevice extends DeviceBaseProperties {
  @doc("Property bag containing the device's inbound and outbound endpoints.")
  endpoints?: MessagingEndpoints;

  @added(Versions.v2025_07_01_preview)
  @doc("Reference to a device. Populated only if the device had been created from discovery flow. Discovered device name must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  discoveredDeviceRef?: string;
}

@doc("The backing AAD identity for the device used for authentication to other services.")
model DeviceIdentity {
  @doc("Principal id for the device resource.")
  @visibility(Lifecycle.Read)
  principalId?: string;

  @doc("Tenant id for the AAD tenant.")
  @visibility(Lifecycle.Read)
  tenantId?: string;
}

@doc("Property bag containing the device's unassigned and assigned endpoints.")
model DeviceEndpoints {
  @doc("Actively used endpoints a device can use to connect to several services.")
  @extension("x-ms-identifiers", #["type", "address"])
  assigned: Endpoint[];

  @doc("List of most recently removed endpoints.")
  @extension("x-ms-identifiers", #["type", "address"])
  @visibility(Lifecycle.Read, Lifecycle.Create)
  unassigned?: Endpoint[];
}

@doc("Property bag contains the device's outbound endpoints")
@added(Versions.v2025_07_01_preview)
model OutboundEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Endpoints the device can connect to.")
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Set of most recently removed endpoints.")
  unassigned?: Record<DeviceMessagingEndpoint>;
}

@doc("Connection endpoint url a device can use to connect to a service.")
model Endpoint {
  @doc("Type of connection endpoint.")
  type?: string;

  @doc("Fully qualified domain name.")
  address?: string;
}

@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model MessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Actively used endpoints a device can use to connect to several services.")
  @removed(Versions.v2024_11_01)
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("List of most recently removed endpoints.")
  @removed(Versions.v2024_11_01)
  unassigned?: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("An endpoint to connect with the device")
  @extension("x-ms-identifiers", #["type", "address"])
  @added(Versions.v2025_07_01_preview)
  inbound?: Record<InboundEndpoints>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Set of endpoints a device can connect to.")
  @extension("x-ms-identifiers", #["type", "address"])
  @added(Versions.v2025_07_01_preview)
  outbound?: Record<OutboundEndpoints>;
}

@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model DeviceMessagingEndpoint {
  @doc("Type of connection used for the endpoint.")
  type?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Fully qualified domain name.")
  address: string;
}

@doc("A type of endpoint to connect to the device.")
@added(Versions.v2025_07_01_preview)
model InboundEndpoints {
  @doc("Type of connection endpoint.")
  // `type` is a reserved keyname. Wrap in double quotes
  type: string;

  @doc("Fully qualified domain name.")
  address: string;

  @doc("Version associated with device endpoint.")
  version?: string;

  @doc("Defines the client authentication mechanism to the server.")
  authentication?: HostAuthentication;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;
}

@doc("Definition of the client authentication mechanism to the host.")
@added(Versions.v2025_07_01_preview)
model HostAuthentication {
  @doc("Defines the anonymous authentication mode.")
  anonymous?: Anonymous;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("Defined Anonymous Authentication")
@added(Versions.v2025_07_01_preview)
model Anonymous {
  @doc("Defines whether anonymous auth is enabled or not.")
  enabled: boolean;
}

@doc("Defines the asset endpoint profile status properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @extension("x-ms-identifiers", #[])
  @visibility(Lifecycle.Read)
  errors?: DeviceStatusError[];
}

@doc("Defines the asset endpoint profile status error properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  @visibility(Lifecycle.Read)
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “targetAddress 'foo' is not a valid url”).")
  @visibility(Lifecycle.Read)
  message?: string;
}
