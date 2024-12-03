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

@doc("GenevaLogsAccount properties")
model GenevaLogsAccountConfigurationResourceProperties {
  @doc("The Geneva Logs account name")
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

  @doc("The array of subscription ids")
  @extension("x-ms-identifiers", [])
  subscriptionIds: Array<string>;

  @doc("The default storage replication type")
  defaultStorageReplicationType: string;

  @doc("The dSMS certificate")
  dsmsCertificate: DsmsCertificate;

  @doc("The KeyVault certificate")
  keyVaultCertificate: KeyVaultCertificate;

  @doc("The array of namespace names")
  @extension("x-ms-identifiers", [])
  namespaceNames: Array<string>;

  @doc("The flag to create default storage groups")
  createDefaultStorageGroups: CreateDefaultStorageGroups;

  @doc("The default Azure region")
  defaultAzureRegion: string;

  @doc("The namespace config")
  namespaceConfig: string;

  @doc("The namespace config main file")
  namespaceConfigMainFile: string;

  @doc("The namespace config import zip")
  namespaceConfigImportZip: string;

  @doc("The namespace config import files")
  @extension("x-ms-identifiers", [])
  namespaceConfigImportFiles: Array<string>;

  @doc("The storage groups")
  @extension("x-ms-identifiers", [])
  storageGroups: Array<StorageGroup>;

  @doc("The user roles")
  @extension("x-ms-identifiers", [])
  userRoles: Array<UserRole>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: GenevaLogsProvisioningState;

  @doc("Resource event argument result; a part of provisioning ResultData output.")
  @visibility("read") // A part of provisioning ResultData output, gets PATCHed back from FRP.
  configDetails?: ConfigDetails;
}

@doc("Create default storage group flag values")
union CreateDefaultStorageGroups {
  @doc("Create default storage groups")
  Yes: "True",

  @doc("Do not create default storage groups")
  No: "False",

  string,
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
  agentClaims: Array<string>;

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

@doc("genevaLogsAccountConfiguration Resource")
model GenevaLogsAccountConfigurationResource
  is ProxyResource<GenevaLogsAccountConfigurationResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("genevaLogsAccountConfigurations") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenevaLogsAccountConfiguration {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenevaLogsAccountConfigurationResource>;
  listBySubscription is ArmListBySubscription<GenevaLogsAccountConfigurationResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaLogsAccountConfigurationResource>;
  get is ArmResourceRead<GenevaLogsAccountConfigurationResource>;
}
