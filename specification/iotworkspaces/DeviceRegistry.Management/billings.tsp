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
using OpenAPI;

namespace Private.DeviceRegistry;

@added(global.Private.DeviceRegistry.Versions.v2024_05_01_preview)
@doc("billingContainer Model as ARM resource")
@subscriptionResource
model BillingContainer is ProxyResource<BillingContainerProperties> {
  @doc("Name of the billingContainer.")
  @key("billingContainerName")
  @segment("billingContainers")
  @pattern("^[0-9a-z][a-z0-9-]*$")
  @path 
  @minLength(3)
  @maxLength(64)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag")
  @visibility("read")
  etag?: string;
}

@added(global.Private.DeviceRegistry.Versions.v2024_05_01_preview)
@doc("Defines the billingContainer properties.")
model BillingContainerProperties { 
  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@added(global.Private.DeviceRegistry.Versions.v2024_05_01_preview)
@armResourceOperations
interface BillingContainers {
  get is ArmResourceRead<BillingContainer>;

  createOrReplace is ArmResourceCreateOrReplaceAsync<BillingContainer>;

  // we don't have updatable property today, when we have it uncomment the below run tsp compile .
  // update is ArmResourcePatchAsync<BillingContainer, BillingContainerProperties>;

  delete is ArmResourceDeleteWithoutOkAsync<BillingContainer>;

  listByResourceGroup is ArmResourceListByParent<BillingContainer>;
}