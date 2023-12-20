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

@doc("storageAccountDsms properties.")
model StorageAccountDsmsResourceProperties {
  @doc("Gets or sets the root path of the certificate.")
  rootPath?: string;

  @doc("Define in which region of dSMS to provision the storage account such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). This is used only when provision storage account in non-home-dsms endpoint.")
  dsmsDns?: string;

  @doc("Subscription ID to use this xstore account.")
  subscriptionId?: string;

  @doc("Account type on data replicateion.")
  accountReplicationType?: string;

  @doc("Owner of this storage account.")
  owner?: string;

  @doc("Alias to find existing subscription.")
  subscriptionAlias?: string;

  @doc("Description to this xstore account.")
  description?: string;

  @doc("Location of this storage account.")
  location?: string;

  @doc("Label of this xstore account.")
  label?: string;

  @doc("Gets or sets whether to enable 2TB for this xstore account.")
  enable2tb?: boolean;

  @doc("If false, create storage account and dSMS object in Deferred Provisioning. If true, create dSMS object in Provisioning, then create storage account in Deferred Provisioning and refresh keys in dSMS. Optional, true by default.")
  xstoreBootstrapping?: boolean;

  @doc("Gets or sets the name of the event to emit once the XStore account is created.")
  eventEmittedUponProvisioning?: string;

  @doc("Storage account whitelist in dSMS.")
  whitelists?: Whitelists;

  @doc("Storage account Replication in dSMS.")
  replicate?: Replicate;

  @doc("Block auto key roll over.")
  blockAutoRollover?: boolean;

  @doc("Override default key renewal period.")
  keyRenewalPeriodInDays?: int32;

  @doc("Make the key available to agents.")
  releaseKeyToAgent?: boolean;

  @doc("If false, skip global sync of dSMS secret. If true, global sync of dSMS secret. Optional, false by default.")
  forceSyncGlobalDsmsSecret?: boolean;

  @doc("Storage account resource group name.")
  resourceGroupName?: string;

  @doc("Storage account resource provider. Valid values are \"Classic\", \"ARM\".")
  resourceProvider?: string;

  @doc("Whether to pilot Xstore resource provider. In new region or new cloud scenario, it can create storage account at earlier stage before ARM ready. This is mainly as a replacement for Classic resource provider which will be deprecated with RDFE.")
  pilotXstoreResourceProvider?: string;

  @doc("Storage account shared access signature.")
  accountSasInfos?: AccountSasInfo[];

  @doc("Residency boundary, e.g Worldwide, National.")
  residencyBoundary?: string;

  @doc("The minimum account replication type, e.g. Standard_LRS. If it's set, then will enable VRS feature for the storage account, and the 'AccountReplicationType' property will not be used.")
  resiliencyMinimum?: string;

  @doc("The maximum account replication type, e.g. Standard_ZRS.")
  resiliencyMaximum?: string;

  @doc("Resiliencies progression id, e.g. Default.")
  resilienciesProgressionId?: string;

  @doc("Additional locations to support resiliency, e.g. primary.")
  additionalLocations?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: StorageAccountDsmsProvisioningState;

  @doc("Properties list")
  propertiesList?: Properties;
}

@doc("Defines the array of whitelists for a secret.")
model Whitelists {
  @doc("Gets or sets the whitelist elements.")
  elements?: Whitelist[];
}

@doc("Defines the array of properties.")
model Properties {
  @doc("Gets or sets the whitelist elements.")
  elements?: Property[];
}

@doc("Defines the property element.")
model Property {
  @doc("Gets or sets the name of the property.")
  name?: string;

  @doc("Gets or sets the value of the property.")
  value?: string;
}

@doc("Defines the whitelist element for a secret.")
model Whitelist {
  @doc("Gets or sets the type of the whitelist.")
  type?: string;

  @doc("Gets or sets the values of the whitelist. A list of values are separated by semicolon.")
  values?: string;
}

@doc("Defines where the secret should be replicated to.")
model Replicate {
  @doc("Local: This secret is not replicated to other dSMS instance. AllDsmsRegions: This secret can be replicated to all dSMS instances. SpecifiedDsmsRegions: This secret can only be replicated to the specified dSMS instances.")
  type?: string;

  @doc("Gets or sets the regions the secret will be replicated to (Applicable when the type of replication is SpecifiedDsmsRegions). Regions are separated by semicolon.")
  values?: string;
}

@doc("Sas Key Information.")
model AccountSasInfo {
  @doc("dSMS root folder.")
  rootPath?: string;

  @doc("Name of the storage account.")
  name?: string;

  @doc("Path in Dsms endpoint. If this specified, then RootPath and Name should be ignored.")
  dsmsLocation?: string;

  @doc("The signed permissions for the account SAS. Possible values include: Read (r), Write (w), Delete (d), List (l), Add (a), Create (c), Update (u) and Process (p).")
  signedPermissions?: string;

  @doc("Services like blob(b), queue(q) and table(t).")
  signedServices?: string;

  @doc("The signed resource types that are accessible with the account SAS. Service (s)/Container (c)/Object (o).")
  signedResourceTypes?: string;
}

@doc("storageAccounts Resource")
model StorageAccountDsmsResource
  is ProxyResource<StorageAccountDsmsResourceProperties> { // This can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("storageAccountDsmss") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface StorageAccountDsms {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageAccountDsmsResource>;
  listBySubscription is ArmListBySubscription<StorageAccountDsmsResource>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountDsmsResource>;
  get is ArmResourceRead<StorageAccountDsmsResource>;
}
