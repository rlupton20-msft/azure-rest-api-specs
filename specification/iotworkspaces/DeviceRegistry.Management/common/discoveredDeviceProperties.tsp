import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./authenticationMethod.tsp";
import "./deviceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@doc("Defines the Discovered Asset Endpoint Profile properties.")
@added(Versions.v2025_07_01_preview)
model DiscoveredDeviceProperties {
  @doc("A device id in the system external to Azure.")
  externalDeviceId?: string;

  @doc("endpoints for discovered devices.")
  endpoints?: MessagingEndpoints;

  @doc("List of supported authentication methods supported by device for Inbound connections.")
  @extension("x-ms-identifiers", #[])
  supportedAuthenticationMethods?: AuthenticationMethod[];

  @doc("Identifier used to detect changes in the asset endpoint profile.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}
