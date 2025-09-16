import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("GenevaLogsAccounts properties")
model GenevaLogsAccountsResourceProperties {
  @doc("The name of the warm path account. This must be unique. Logs Account name must start with a letter and can contain numbers/letters.")
  @pattern("^[a-zA-Z0-9-]{6,32}$")
  accountName: string;

  @doc("The MDS environment")
  mdsEnvironment: MdsEnvironment;

  @doc("The metrics account name")
  metricsAccountName: string;

  @doc("The contact email")
  contactEmail: string;

  @doc("The array of aliases for administrators")
  @extension("x-ms-identifiers", [])
  administratorAliases: Array<string>;

  @doc("The security group for account administrator")
  administratorSecurityGroup: string;

  @doc("An Azure subscription to use for GSM provisioning. Each subscription in the list must have granted Geneva access via RBAC.")
  @extension("x-ms-identifiers", [])
  subscriptionIds: Array<string>;

  @doc("The default storage replication type")
  defaultStorageReplicationType: string;

  @doc("DSMS certificate for configuring the MACommunication User Role.")
  dsmsCertificate?: DsmsCertificate;

  @doc("Key Vault certificate for configuring the MACommunication User Role.")
  keyVaultCertificate?: KeyVaultCertificate;

  @doc("Namespaces to register with MDS.")
  @extension("x-ms-identifiers", [])
  namespaceNames: Array<string>;

  @doc("Flag, indicating whether to create default storage groups.")
  createDefaultStorageGroups: boolean;

  @doc("Region where the initial monikers would be created for default storage groups.")
  defaultAzureRegion?: string;

  @doc("SAS for config package zip file containing a configuration to upload.")
  namespaceConfig?: string;

  @doc("Specifies the SAS for configuration main file, if provided instead of config package zip file.")
  namespaceConfigMainFile?: string;

  @doc("Specifies the SAS for zip import file.")
  namespaceConfigImportZip?: string;

  @doc("Explicitly specify SAS for each import file, if provided not in zip format.")
  @extension("x-ms-identifiers", [])
  namespaceConfigImportFiles?: Array<string>;

  @doc("Define custom storage groups instead of using the default storage groups, and setup Kusto streaming.")
  @extension("x-ms-identifiers", [])
  storageGroups?: Array<StorageGroup>;

  @doc("Define custom user roles in addition to the user roles created by default (MaCommunication and MdsAccountAdmin roles).")
  @extension("x-ms-identifiers", [])
  userRoles?: Array<UserRole>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: GenevaLogsProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  configDetails?: ConfigDetails;
}

@doc("Storage Group")
model StorageGroup {
  @doc("The config namespace")
  configNamespace: string;

  @doc("The storage group name")
  storageGroupName: string;

  @doc("The default region")
  defaultRegion: string;

  @doc("The storage replication types")
  @extension("x-ms-identifiers", [])
  storageReplicationTypes: Array<string>;

  @doc("The consumer groups")
  @extension("x-ms-identifiers", [])
  consumerGroups: Array<string>;

  @doc("The region based Kusto settings mode")
  regionBasedKustoSettingsMode: KustoSettingsMode;

  @doc("The region based Kusto settings")
  @extension("x-ms-identifiers", [])
  regionBasedKustoSettings: Array<RegionBasedKustoSetting>;
}

@doc("Region based Kusto setting")
model RegionBasedKustoSetting {
  @doc("The setting region")
  region: string;

  @doc("The log analytics id")
  logAnalyticsId: string;

  @doc("The log analytics database")
  logAnalyticsDatabase: string;
}

@doc("User role")
model UserRole {
  @doc("The user role name")
  name: string;

  @doc("The security groups")
  @extension("x-ms-identifiers", [])
  securityGroups: Array<string>;

  @doc("The users")
  @extension("x-ms-identifiers", [])
  users: Array<string>;

  @doc("The dSMS certificates")
  @extension("x-ms-identifiers", [])
  dsmsCertificates: Array<DsmsCertificate>;

  @doc("The KeyVault certificates")
  @extension("x-ms-identifiers", [])
  keyVaultCertificates: Array<KeyVaultCertificate>;

  @doc("The MSI configurations")
  @extension("x-ms-identifiers", [])
  msiConfigs: Array<MsiConfig>;

  @doc("The list of AutoPilot Public Key Infrastructure Access Control Lists")
  @extension("x-ms-identifiers", [])
  appkiAcl: Array<string>;

  @doc("The agent claims")
  @extension("x-ms-identifiers", [])
  agentClaims: Array<AgentClaim>;

  @doc("The config claims")
  @extension("x-ms-identifiers", [])
  configClaims: Array<ConfigClaim>;
}

@doc("Config claim")
model ConfigClaim {
  @doc("The resource")
  resource: string;

  @doc("The right")
  right: string;
}

@doc("Agent claim")
model AgentClaim {
  @doc("The namespace regex")
  namespaceRegex: string;

  @doc("The right")
  right: string;
}

@doc("MSI configuration")
model MsiConfig {
  @doc("The object identifier")
  objectId: string;

  @doc("The tenant identifier")
  tenantId: string;

  @doc("The resource identifier")
  resourceId: string;

  @doc("The description")
  description: string;
}

@doc("KeyVault certificate")
model KeyVaultCertificate {
  @doc("The root certificate thumbprint")
  rootCertificateThumbprint: string;

  @doc("The SAN")
  san: string;

  @doc("The description")
  description: string;
}

@doc("DSMS certificate")
model DsmsCertificate {
  @doc("The description")
  description: string;

  @doc("The identity")
  identity: string;
}

@doc("Kusto settings mode")
union KustoSettingsMode {
  @doc("Append")
  Append: "Append",

  @doc("Reset")
  Reset: "Reset",

  string,
}

@doc("MDS environment")
union MdsEnvironment {
  @doc("Smoke emvironment")
  Smoke: "Smoke",

  @doc("Canary environment")
  Canary: "Canary",

  @doc("Test environment")
  Test: "Test",

  @doc("Stage environment")
  Stage: "Stage",

  @doc("DiagnosticsProd environment")
  DiagnosticsProd: "DiagnosticsProd",

  @doc("FirstPartyProd environment")
  FirstPartyProd: "FirstPartyProd",

  @doc("BillingProd environment")
  BillingProd: "BillingProd",

  @doc("CaFairfax environment")
  CaFairfax: "CaFairfax",

  @doc("CaMooncake environment")
  CaMooncake: "CaMooncake",

  @doc("CaBlackForest environment")
  CaBlackForest: "CaBlackForest",

  @doc("UsSec environment")
  UsSec: "UsSec",

  @doc("UsNat environment")
  UsNat: "UsNat",

  @doc("ExternalProd environment")
  ExternalProd: "ExternalProd",

  @doc("CanaryEast environment")
  CanaryEast: "CanaryEast",

  @doc("CanaryWest environment")
  CanaryWest: "CanaryWest",

  @doc("CanaryNorth environment")
  CanaryNorth: "CanaryNorth",

  @doc("CanarySouth environment")
  CanarySouth: "CanarySouth",

  @doc("Bleu environment")
  Bleu: "Bleu",

  @doc("Delos environment")
  Delos: "Delos",

  @doc("GovSG environment")
  GovSG: "GovSG",

  string,
}

@doc("Configuration details result")
model ConfigDetails {
  @doc("Configuration version")
  configVersion: string;
}

@doc("genevaLogsAccounts Resource")
model GenevaLogsAccountsResource
  is ProxyResource<GenevaLogsAccountsResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("genevaLogsAccountss") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenevaLogsAccountConfiguration {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenevaLogsAccountsResource>;
  listBySubscription is ArmListBySubscription<GenevaLogsAccountsResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaLogsAccountsResource>;
  get is ArmResourceRead<GenevaLogsAccountsResource>;
}
