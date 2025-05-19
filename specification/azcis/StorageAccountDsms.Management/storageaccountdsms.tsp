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

  @doc("Name of the event to emit once the XStore account is created.")
  eventEmittedUponProvisioning?: string;

  @doc("Storage Account resource provider. Acceptable values: Classic (for RDFE Storage Accounts), ARM (StorageV2 (general purpose v2) on Azure Portal).")
  resourceProvider: "Classic" | "ARM" | string;

  @doc("Residency boundary. Acceptable values: Worldwide, National.")
  residencyBoundary?: "Worldwide" | "National" | string;

  @doc("Minimum account replication type, e.g. Standard_LRS. If it's set, it will enable VRS feature for the Storage Account, and the 'AccountReplicationType' property will not be used.")
  resiliencyMinimum?: string;

  @doc("Maximum account replication type, e.g. Standard_ZRS.")
  resiliencyMaximum?: string;

  @doc("Resiliencies progression id. Acceptable values: Default, PremiumDefault, Zonal.")
  resilienciesProgressionId?: "Default" | "PremiumDefault" | "Zonal" | string;

  @doc("Additional locations to support resiliency, e.g. primary.")
  additionalLocations?: string;

  @doc("An array of Lifecycle Management Policy rules.")
  lifecycleManagementPolicy?: Array<LifecycleManagementPolicyRule>;

  @doc("Set to False to prevent refreshing in dSMS after creating Storage Account. Optional, True by default.")
  refreshInDsms?: boolean;

  @doc("The original resource provider from StorageAccountDsmsTemplate, which would be used if not pilot Xstore resource provider. Add the property to support transition from Classic to Xstore/ARM resource provider.")
  originalResourceProvider?: string;

  @doc("Dual Stack Endpoint Preference.")
  dualStackEndpointPreference?: DualStackEndpointPreference;

  @doc("Defines if Infrastructure Encryption is required.")
  requireInfrastructureEncryption?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Properties can be used to save customer key-value pairs associated with the dSMS secrets. Optional.")
  properties?: {};

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: StorageAccountDsmsProvisioningState;

  @doc("Storage Account dSMS object name; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsName?: string;

  @doc("Storage Account dSMS object resource provider; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountDsmsResourceProviderName?: string;

  @doc("Storage Account ARM creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountArmCreationTime?: string;

  @doc("Storage Account rdfe creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountRdfeCreationTime?: string;

  @doc("Storage Account XStore creation time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  storageAccountXstoreCreationTime?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase."
  @doc("Resource template provision start time; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  provisionStartTime_StorageAccountTemplate?: string;
}

@doc("Lifecycle Management Policy Rule for Storage Account.")
model LifecycleManagementPolicyRule {
  @doc("Name of the policy rule.")
  name: string;

  @doc("Indicates whether the rule is enabled.")
  enabled: boolean;

  @doc("Policy for base blobs.")
  @extension("x-ms-identifiers", #[])
  baseBlobPolicy: Array<LcmActionPolicy>;

  @doc("Policy for snapshots.")
  @extension("x-ms-identifiers", #[])
  snapshotPolicy: Array<LcmActionPolicy>;

  @doc("Policy for versions.")
  @extension("x-ms-identifiers", #[])
  versionPolicy: Array<LcmActionPolicy>;

  @doc("A string, containing BlobTypes to filter, separated with a semicolon. Acceptable values: 'blockBlob', 'appendBlob'.")
  blobTypesFilter: string;

  @doc("List of prefixes to filter by.")
  prefixMatchFilter: Array<string>;

  @doc("List of blob index match filters.")
  blobIndexMatchFilter: Array<BlobIndexMatch>;
}

@doc("Lifecycle Management Policy details for a specific action in a rule.")
model LcmActionPolicy {
  @doc("Action to be performed. Acceptable values: tierToCool, tierToArchive, tierToCold, tierToHot, delete.")
  action: string;

  @doc("Days after modification greater than.")
  daysAfterModificationGreaterThan?: int32;

  @doc("Days after last access time greater than.")
  daysAfterLastAccessTimeGreaterThan?: int32;

  @doc("Days after last tier change greater than (specific to tierToArchive action).")
  daysAfterLastTierChangeGreaterThan?: int32;

  @doc("Days after creation greater than.")
  daysAfterCreationGreaterThan?: int32;
}

@doc("Blob Index Match filter.")
model BlobIndexMatch {
  @doc("Filter tag name.")
  name: string;

  @doc("Comparison operator.")
  operator: string;

  @doc("Filter tag value.")
  value: string;
}

@doc("Dual Stack Endpoint Preference.")
model DualStackEndpointPreference {
  @doc("Enable default dual stack endpoints.")
  defaultDualStackEndpoints?: boolean;

  @doc("Publish IPv4 endpoint.")
  publishIpv4Endpoint?: boolean;

  @doc("Publish IPv6 endpoint.")
  publishIpv6Endpoint?: boolean;
}

@doc("StorageAccount Resource")
model StorageAccountDsmsResource
  is ProxyResource<StorageAccountDsmsResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("storageAccountDsms") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
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
