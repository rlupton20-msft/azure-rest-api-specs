import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AadApplication;

@doc("AadApplication properties")
model AadApplicationResourceProperties {
  @doc("Display name of the AAD Application resource. Also used as a key to make the resource idempotent. Must be unique in the tenant. Case-insensitive.")
  applicationName: string; // Camel case for the parameter names.

  @doc("Tenant Id of the AAD Application resource.")
  tenantId: string;

  @doc("The value defines if the AAD Application resource is available to other tenants. False by default.")
  availableToOtherTenants?: string;

  @doc("App ID Uri of a multiple-tenant AAD Application resource. Must be globally unique.")
  appIdUri?: string;

  @doc("SN Issuer config of an AAD Application resource.")
  snIssuerConfig?: Array<string>;

  @doc("List of the owners of an AAD Application resource.")
  owners?: Array<string>;

  @doc("List of the AD groups to join for an AAD Application resource.")
  adGroupsToJoin?: Array<string>;

  @doc("List of the certificates paths for an AAD Application resource.")
  certificates?: Array<string>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: AadApplicationProvisioningState;

  @doc("Application ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  applicationId?: string;

  @doc("Object ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  objectId?: string;

  @doc("Service Principal Object ID; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  servicePrincipalObjectId?: string;
}

@doc("AadApplication Resource")
model AadApplicationResource
  is ProxyResource<AadApplicationResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("aadApplications") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
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
