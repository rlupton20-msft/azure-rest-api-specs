import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("AadApplication properties")
model AadApplicationResourceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("The name of the AAD Application resource, case-insensitive.")
  name: string; // Camel case for the parameter names.

  @doc("The name of the AAD Application Tenant Id.")
  tenantId: string;

  @doc("The value defines if the AAD Application is available to other tenants. False by default.")
  availableToOtherTenants?: string;

  @doc("The App ID Uri of multiple-tenant application to be globally unique.")
  appIdUri?: string;

  @doc("The Subject Name for SNIssuer Config.")
  snIssuerConfig?: Array<string>;

  @doc("The Owners of the AAD Application.")
  owners?: Array<string>;

  @doc("The AD Groups to join.")
  adGroupsToJoin?: Array<string>;

  @doc("The certificate paths of the AAD Application.")
  certificates?: Array<string>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: AadApplicationProvisioningState;
}

@doc("AadApplication Resource")
model AadApplicationResource
  is ProxyResource<AadApplicationResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("aadApplications") // Start with lower case. Should be plural.
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface AadApplication {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AadApplicationResource>;
  get is ArmResourceRead<AadApplicationResource>;
  listByResourceGroup is ArmResourceListByParent<AadApplicationResource>;
  listBySubscription is ArmListBySubscription<AadApplicationResource>;
}
