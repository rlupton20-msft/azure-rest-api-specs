import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";
import "./status.tsp";

using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;

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
  @removed(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceTemplateId?: string;

  @doc("The AAD group the device is a member of.")
  @removed(Versions.v2025_07_01_preview)
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
  @removed(Versions.v2025_07_01_preview)
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
model NamespaceDeviceProperties extends DeviceBaseProperties {
  @doc("Property bag containing the device's inbound and outbound endpoints.")
  endpoints?: MessagingEndpoints;

  @added(Versions.v2025_07_01_preview)
  @doc("Reference to a device. Populated only if the device had been created from discovery flow. Discovered device name must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  discoveredDeviceRef?: string;

  @doc("Hardware manufacturer name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_07_01_preview)
  manufacturer?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Model name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `model`?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Operating system name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystem?: string;

  @doc("Operating system version.")
  @added(Versions.v2025_07_01_preview)
  operatingSystemVersion?: string;

  @doc("Device status updates.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  status?: DeviceStatus;

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  version?: int64;

  @doc("A timestamp that is updated each time the resource is modified.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  lastTransitionTime?: utcDateTime;

  @added(Versions.v2025_08_01_preview)
  @doc("Policy used to issue device certificates.")
  policy?: DeviceCredentialPolicy;

  @added(Versions.v2025_08_01_preview)
  @doc("Policy used to issue device certificates.")
  internalMetadata?: DeviceInternalMetadata;
}

@added(Versions.v2025_08_01_preview)
@doc("Defines the internal metadata for the device.")
model DeviceInternalMetadata {
  @doc("Resource Id of the Policy.")
  credentials?: CredentialsMetadata;
}

@added(Versions.v2025_08_01_preview)
@doc("Defines the credentialsMetadata for the device.")
model CredentialsMetadata {
  @doc("Resource Id of the Policy.")
  credentialId?: string;

  @doc("The name of field on certificate that contains the Id.")
  validationScheme?: string;
}

@added(Versions.v2025_08_01_preview)
@doc("Defines the Policy used to issue device certificates if any.")
model DeviceCredentialPolicy {
  @doc("Resource Id of the Policy.")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/credentials/policies";
    }
  ]>;
}

@doc("The backing AAD identity for the device used for authentication to other services.")
@removed(Versions.v2025_07_01_preview)
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
  outbound?: OutboundEndpoints;
}

@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model DeviceMessagingEndpoint {
  @doc("Type of connection used for the endpoint.")
  @removed(Versions.v2025_07_01_preview)
  type?: string;

  @doc("Type of connection used for the endpoint.")
  @added(Versions.v2025_07_01_preview)
  endpointType?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Fully qualified domain name.")
  address: string;
}

@doc("A type of endpoint to connect to the device.")
@added(Versions.v2025_07_01_preview)
model InboundEndpoints {
  @doc("Type of connection endpoint.")
  endpointType?: string;

  @doc("Fully qualified domain name.")
  address: string;

  @doc("Protocol version associated with the endpoint e.g. 1 or 2 for endpointType Microsoft.HTTP, and 3.5 or 5.0 for endpointType Microsoft.Mqtt etc.")
  version?: string;

  @doc("Defines the client authentication mechanism to the server.")
  authentication?: HostAuthentication;

  @doc("Defines server trust settings for the endpoint.")
  trustSettings?: TrustSettings;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;
}

@doc("Defines server trust settings for an endpoint.")
@added(Versions.v2025_07_01_preview)
model TrustSettings {
  @doc("Defines a secret reference for certificates to trust. Either trustList or issuerList is required when autoTrust is set to false.")
  trustList?: string;

  @doc("Defines a secret reference for certificate issuers to trust. Either trustList or issuerList is required when autoTrust is set to false.")
  issuerList?: string;
}

@doc("Definition of the client authentication mechanism to the host.")
@added(Versions.v2025_07_01_preview)
model HostAuthentication {
  @doc("Defines the authentication method.")
  // Default mode is Certificate
  method: AuthenticationMethod = AuthenticationMethod.Certificate;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("Defines the asset endpoint profile status properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatus {
  @doc("Defines the device status config properties.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  config?: StatusConfig;

  @doc("Defines the device status endpoint properties.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  endpoints?: DeviceStatusEndpoints;
}

@doc("Defines the asset status dataset properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatusEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Object to transfer and persist errors that originate from the Edge.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  inbound?: Record<DeviceStatusEndpoint>;
}

@doc("Defines the asset status dataset properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatusEndpoint {
  @doc("Object to transfer and persist errors that originate from the Edge.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  error?: StatusError;
}
