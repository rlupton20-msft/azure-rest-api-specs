import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("Subscription properties.")
model SubscriptionResourceProperties {
  @doc("The unique identifier for CIS to locate the subscription provisioned.")
  `alias`: string; // Camel case for the parameter names.

  @doc("Name of the subscription that needs to be provisioned.")
  subscriptionName: string;

  @doc("Service Tree Environment, Production or NonProduction.")
  serviceTreeEnvironment?: string;

  @doc("Enrollment Account id for the subscription creation.")
  enrollmentAccountId?: string;

  @doc("The Profit Center that the subscription will be billed to.")
  pcCode?: string;

  @doc("Cost category is a sub-classification within the chosen Profit Center code.")
  costCategory?: string;

  @doc("Offer type for the subscription creation.")
  offerType?: string;

  @doc("Subscription Tenant id.")
  subscriptionTenantId: string;

  @doc("Enrollment Account Tenant id.")
  enrollmentAccountTenantId: string;

  @doc("The object id of the team's AAD Application that will be assigned an Azure RBAC Owner Role of the subscription to be provisioned.")
  ownerObjectId?: string;

  @doc("Service id for tagging the subscription.")
  serviceId?: string;

  @doc("Secret store path of management cert for the subscription.")
  managementCert?: string;

  @doc("True if the subscription to be provisioned is hosted on behalf of external customer, False otherwise.")
  hostedOnBehalfOfCustomer?: boolean;

  @doc("Maximum number of storage accounts allowed for the subscription.")
  maxStorageAccountCount?: string;

  @doc("Additional Azure RBAC roles to be added to the subscription to be provisioned (ex. [{role1...},{role2...}]).")
  customRoles?: string;

  @doc("True to disable RBAC role check, False otherwise.")
  disableRbacRoleCheck?: boolean;

  @doc("An existing subscription under the same enrollment account of the subscription to be provisioned.")
  sampleSubscription?: string;

  @doc("Rdfe Provisioning Policy control # of VM/VNet etc. default: AzureCIS.")
  rdfeProvisioningPolicy?: string;

  @doc("The id of the billing account. Usually, this is a constant for every service team.")
  billingAccountId?: string;

  @doc("The id of the billing profile, Usually, this is a team's service group id.")
  billingProfileId?: string;

  @doc("The id of the invoice section. Usually, this is a team's service tree id.")
  invoiceSectionId?: string;

  @doc("The workload type of the subscription. Allowed values are Production and DevTest.")
  workLoad?: string;

  @doc("Ev2 Subscription Key of an existing subscription which is created by Ev2.")
  ev2SubscriptionKey?: string;

  @doc("Ev2 Service Group of an existing subscription which is created by Ev2.")
  ev2ServiceGroup?: string;

  @doc("DSMS Root Folders of SubscriptionManagement.")
  @Azure.ResourceManager.identifiers(#[])
  dsmsFolderWhitelists?: Array<DsmsFolderWhitelist>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: SubscriptionProvisioningState;

  @doc("List of Subscription IDs; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  subscriptionId?: Array<string>;

  @doc("List of RBAC Roles; a part of provisioning ResultData output.")
  @Azure.ResourceManager.identifiers(#[])
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  rbacRoles?: Array<RbacRole>;

  @doc("List of ARM Features; a part of provisioning ResultData output.")
  @Azure.ResourceManager.identifiers(#[])
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  armFeatures?: Array<ArmFeatureRegistration>;

  @doc("List of DSMS Root Folders Whitelists; a part of provisioning ResultData output.")
  @Azure.ResourceManager.identifiers(#[])
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  dsmsRootFolderWhitelists?: Array<DsmsFolderWhitelist>;
}

@doc("Subscription resource.")
model SubscriptionResource
  is ProxyResource<SubscriptionResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("subscriptions") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("ARM Feature registration.")
model ArmFeatureRegistration {
  @doc("Resource Provider namespace.")
  resourceProviderNamespace: string;

  @doc("Feature name.")
  featureName: string;
}

@doc("DSMS Root Folder Whitelist.")
model DsmsFolderWhitelist {
  @doc("DSMS Root Folder path.")
  folderPath: string;

  @doc("DSMS Whitelist type.")
  whitelistType: string;
}

@doc("RBAC Role.")
model RbacRole {
  @doc("Tenant id.")
  tenantId: string;

  @doc("Object id.")
  objectId: string;

  @doc("RoleDefinition id.")
  roleDefinitionId: string;

  @doc("Principal Type.")
  principalType: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface Subscription {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SubscriptionResource>;
  get is ArmResourceRead<SubscriptionResource>;
  listByResourceGroup is ArmResourceListByParent<SubscriptionResource>;
  listBySubscription is ArmListBySubscription<SubscriptionResource>;
}
