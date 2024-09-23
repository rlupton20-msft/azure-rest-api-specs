import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using OpenAPI;

namespace Private.DeviceRegistry;
@doc("Defines the device base properties.")
model DeviceBaseProperties {
  @doc("Gets a unique identifier for this resource.")
  @visibility("read")
  uuid?: string;

  @doc("Indicates if the resource and identity are enabled or not. A disabled device cannot authenticate with AAD.")
  enabled?: boolean = true;

  @doc("Gets the device Id provided by customer.")
  @visibility("read", "create")
  externalDeviceId?: string;

  @doc("Device Template Id used to create a device.")
  @visibility("read", "create")
  deviceTemplateId?: string;

  @doc("The AAD group the device is a member of.")
  deviceGroupId?: string;

  @doc("Hardware manufacturer name.")
  @visibility("read")
  manufacturer?: string;

  @doc("Hardware model name.")
  @visibility("read")
  `model`?: string;

  @doc("operating system name.")
  @visibility("read")
  operatingSystem?: string;

  @doc("operating system version.")
  @visibility("read", "create")
  operatingSystemVersion?: string;

  @doc("Identity for the resource.")
  @visibility("read", "create")
  identity?: DeviceIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Provisioning state of the resource.")
  @visibility("read")
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
@doc("Defines the device properties.")
model DeviceProperties_V2024_10_01_Preview extends DeviceBaseProperties {
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: MessagingEndpoints;
}

@doc("The backing AAD identity for the device used for authentication to other services.")
model DeviceIdentity {
  @doc("Principal id for the device resource.")
  @visibility("read")
  principalId?: string;

  @doc("Tenant id for the AAD tenant.")
  @visibility("read")
  tenantId?: string;
}

@doc("Property bag containing the device's unassigned and assigned endpoints.")
model DeviceEndpoints {
  @doc("Actively used endpoints a device can use to connect to several services.")
  @extension("x-ms-identifiers", ["type", "address"])
  assigned: Endpoint[];

  @doc("List of most recently removed endpoints.")
  @extension("x-ms-identifiers", ["type", "address"])
  @visibility("read", "create")
  unassigned?: Endpoint[];
}

@doc("Connection endpoint url a device can use to connect to a service.")
model Endpoint {
  @doc("Type of connection endpoint.")
  type?: string;

  @doc("Fully qualified domain name.")
  address?: string;
}
