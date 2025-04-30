import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.DeviceRegistry;
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("Namespace definition.")
model Namespace is TrackedResource<NamespaceProperties> {
  @doc("Namespace name parameter.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}
@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("Defines the container registry proprties.")
model Messaging {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: Record<MessagingEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("Defines the container registry proprties.")
model NamespaceProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  messaging?: Messaging;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@doc("Connection endpoint url a device can use to connect to a service.")
model MessagingEndpoint {
  @doc("Type of connection used for the endpoint.")
  @removed(Versions.v2024_11_01)
  @removed(Versions.v2025_07_01_preview)
  type?: string;

  @doc("Type of connection used for endpoint.")
  @added(Versions.v2025_07_01_preview)
  endpointType?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("The endpoint address to connect to.")
  address: string;

  @doc("The complete ARM resourceId for the messaging endpoint.")
  resourceId?: string;
}

@added(Versions.v2024_10_01_preview)
@removed(Versions.v2024_11_01)
@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmResourcePatchAsync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;
}
