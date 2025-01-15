import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("StorageAccountDsms properties.")
model StorageAccountDsmsResourceProperties {
  @doc("Name of the Storage Account.")
  accountName: string; // Camel case for the parameter names.

  @doc("Root path of the certificate.")
  rootPath: string;

  @doc("Defines in which region of dSMS to provision the Storage Account, such as global-dsms.dsms.%(HostNameSuffix), uswest-dsms.dsms.%(HostNameSuffix). Used only for provisioning Storage Account in non-home-dsms endpoint.")
  dsmsDns?: string; // Can be a part of provisioning ResultData output, and get PATCHed back from FRP.

  @doc("Account Replication Type.")
  accountReplicationType?: string;

  @doc("Description of the XStore account.")
  description?: string;

  @doc("Location of the Storage Account.")
  location?: string;

  @doc("Label of the XStore account.")
  label?: string;

  @doc("If False, create Storage Account and dSMS object in Deferred Provisioning; if True, create dSMS object in Provisioning, then create Storage Account in Deferred Provisioning and refresh keys in dSMS. Optional, True by default.")
  xstoreBootstrapping?: boolean;

  @doc("Name of the event to emit once the XStore account is created.")
  eventEmittedUponProvisioning?: string;

  @doc("If True, will onboard the existing Storage Account to dSMS. If False, will generate dSMS object with random keys. Optional, False by default.")
  useCreateInsteadOfGenerate?: boolean;

  @doc("Storage account whitelist in dSMS.")
  whitelists?: Whitelists;

  @doc("Storage account Replication in dSMS.")
  replicate?: Replicate;

  @doc("Set to True to block auto key rollover. Optional, False by default.")
  blockAutoRollover?: boolean;

  @doc("Override default key renewal period.")
  keyRenewalPeriodInDays?: int32;

  @doc("Set to True if you need ACL the Storage Account to Autopilot or PilotFish environments. Optional.")
  releaseKeyToAgent?: boolean;

  @doc("Set to True to force global sync of dSMS secret or False to skip it. Optional, False by default.")
  forceSyncGlobalDsmsSecret?: boolean;

  @doc("Storage Account resource provider. Acceptable values: Classic (for RDFE Storage Accounts), ARM (StorageV2 (general purpose v2) on Azure Portal), Xstore, Invalid (can be used to create dummy Storage Accounts in dSMS).")
  resourceProvider: string;

  @doc("Set to True to pilot XStore resource provider. In new region or new cloud scenario, it can create Storage Account at earlier stage before ARM ready. This is mainly as a replacement for Classic resource provider which will be deprecated with RDFE.")
  pilotXstoreResourceProvider?: boolean;

  @doc("Storage account shared access signature.")
  @extension("x-ms-identifiers", [])
  accountSasInfos?: Array<AccountSasInfo>;

  @doc("Set to False to prevent refreshing in dSMS after creating Storage Account. Optional, True by default.")
  refreshInDsms?: boolean;

  @doc("The original resource provider from StorageAccountDsmsTemplate, which would be used if not pilot Xstore resource provider. Add the property to support transition from Classic to Xstore/ARM resource provider.")
  originalResourceProvider?: string;

  @doc("Residency boundary. Acceptable values: Worldwide, National.")
  residencyBoundary?: string;

  @doc("Minimum account replication type, e.g. Standard_LRS. If it's set, it will enable VRS feature for the Storage Account, and the 'AccountReplicationType' property will not be used.")
  resiliencyMinimum?: string;

  @doc("Maximum account replication type, e.g. Standard_ZRS.")
  resiliencyMaximum?: string;

  @doc("Resiliencies progression id, e.g. Default, PremiumDefault, Zonal.")
  resilienciesProgressionId?: string;

  @doc("Additional locations to support resiliency, e.g. primary.")
  additionalLocations?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Properties can be used to save customer key-value pairs associated with the dSMS secrets. Optional.")
  properties?: {};

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: StorageAccountDsmsProvisioningState;

  @doc("Storage Account dSMS object name; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsName?: string;

  @doc("Storage Account dSMS object resource provider; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsResourceProviderName?: string;

  @doc("Storage Account ARM creation time; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountArmCreationTime?: string;

  @doc("Storage Account rdfe creation time; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountRdfeCreationTime?: string;

  @doc("Storage Account XStore creation time; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountXstoreCreationTime?: string;

  @doc("Resource template provision start time; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  provisionStartTime?: string;
}

@doc("AccountSasInfo element contains Sas Key Information.")
model AccountSasInfo {
  @doc("dSMS root folder.")
  rootPath?: string;

  @doc("Name of the Storage Account.")
  name?: string;

  @doc("Path in Dsms endpoint. If this specified, then RootPath and Name should be ignored.")
  dsmsLocation?: string;

  @doc("The signed permissions for the account SAS. Acceptable values: Read (r), Write (w), Delete (d), List (l), Add (a), Create (c), Update (u) and Process (p).")
  signedPermissions?: string;

  @doc("Services like blob(b), queue(q) and table(t).")
  signedServices?: string;

  @doc("The signed resource types that are accessible with the account SAS. Service (s)/Container (c)/Object (o).")
  signedResourceTypes?: string;
}

@doc("Replicate element defines where the secret should be replicated to.")
model Replicate {
  @doc("Local: This secret is not replicated to other dSMS instance. AllDsmsRegions: This secret can be replicated to all dSMS instances. SpecifiedDsmsRegions: This secret can only be replicated to the specified dSMS instances.")
  type?: string;

  @doc("Regions the secret will be replicated to (Applicable when the type of replication is SpecifiedDsmsRegions). Regions are separated by semicolon.")
  regions?: string;
}

@doc("Whitelist element defines the whitelist for a secret.")
model Whitelist {
  @doc("Type of the whitelist. ServiceID: whitelisting a service. SubscriptionID: whitelisting subscription ID for creating Storage Account objects. DnsDomain: whitelisting a DNS domain for creating chained certificates. ServiceTreeID: whitelisting a service tree ID.")
  type?: string;

  @doc("Values of the whitelist, separated by semicolon.")
  values?: string;
}

@doc("Whitelists element is a wrapper object over a collection of Whitelist elements.")
model Whitelists {
  @doc("Array of whitelists.")
  @extension("x-ms-identifiers", [])
  whitelist?: Array<Whitelist>;
}

@doc("StorageAccount Resource")
model StorageAccountDsmsResource
  is ProxyResource<StorageAccountDsmsResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("storageAccountDsms") // Start with lower case. Should be plural.
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface StorageAccountDsms {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<StorageAccountDsmsResource>;
  get is ArmResourceRead<StorageAccountDsmsResource>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountDsmsResource>;
  listBySubscription is ArmListBySubscription<StorageAccountDsmsResource>;
}
