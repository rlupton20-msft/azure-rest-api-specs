using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.OracleDatabaseDev;

// https://docs.oracle.com/en-us/iaas/api/#/en/goldengate/20200407/Deployment/

@added(Versions.v20251001_preview)
@doc("Deployment resource definition")
model Deployment is TrackedResource<DeploymentProperties> {
  ...ResourceNameParameter<Deployment, NamePattern = ".*">;
  ...AvailabilityZonesProperty;
}

@added(Versions.v20251001_preview)
@doc("Deployment resource model")
model DeploymentProperties {
  @doc("Availability Domain")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  availabilityDomain?: string;

  @doc("Backup Schedule")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  backupSchedule?: BackupScheduleType;

  @doc("OCI Compartment")
  @visibility(Lifecycle.Read)
  compartment?: Ocid;

  @doc("The Minimum number of OCPUs to be made available for this Deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @minValue(1)
  @maxValue(24)
  cpuCoreCount: int32;

  @doc("Display Name")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  displayName: string;

  @doc("The deployment category")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  category: CategoryType = CategoryType.DataReplication;

  @doc("Cluster Placement Group")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  clusterPlacementGroupId?: Ocid;

  @doc("Technology")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  deploymentType: DeploymentType = DeploymentType.DatabaseOracle;

  @doc("HTTPS link to OCI resources exposed to Azure Customer via Azure Interface.")
  @visibility(Lifecycle.Read)
  deploymentUrl?: url;

  @doc("Environment Type")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  environmentType: SetupType;

  @doc("Fault Domain")
  @visibility(Lifecycle.Read)
  faultDomain: string;

  @doc("Indicates if auto scaling is enabled for the Deployment's CPU core count.")
  @visibility(Lifecycle.Create)
  isAutoScalingEnabled?: boolean;

  @doc("Connection Ip Address")
  @visibility(Lifecycle.Read)
  ingressIps?: string[];

  @doc("True if this object is publicly available.")
  @visibility(Lifecycle.Create)
  isPublic?: boolean;

  @doc("The Oracle license model that applies to a Deployment.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  licenseModel?: LicenseModel;

  @doc("Describes the object's current state in detail.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("Possible lifecycle states.")
  @visibility(Lifecycle.Read)
  lifecycleState?: DeploymentLifecycleState;

  @doc("Maintenance Configuration")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  maintenanceConfiguration?: MaintenanceConfigurationType;

  @doc("Maintenance Window")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  maintenanceWindow?: MaintenanceWindowType;

  @doc("Azure Network Anchor ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  networkAnchorId: NetworkAnchorResourceId;

  @doc("Deployment Data for creating an OggDeployment")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  oggData: OggDeploymentDetails;

  @doc("The private IP address of VCN representing the access point for the associated endpoint service in the GoldenGate service VCN")
  @visibility(Lifecycle.Read)
  privateIpAddress?: string;

  @doc("Deployment provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("Corresponding resource anchor Azure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: ResourceAnchorResourceId;

  @doc("Corresponding resource anchor Azure ID")
  @visibility(Lifecycle.Read)
  storageUtilizationInBytes?: int32;

  @doc("The time zone of the Deployment, e.g., UTC, to set the timeZone as UTC.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  timeZone?: string;

  @doc("The current version")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  version: string;
}

@added(Versions.v20251001_preview)
@doc("Category")
union CategoryType {
  @doc("Data Replication")
  DataReplication: "DataReplication",

  @doc("Stream Analytics")
  StreamAnalytics: "StreamAnalytics",

  @doc("Data Transforms")
  DataTransforms: "DataTransforms",

  string,
}

@added(Versions.v20251001_preview)
@doc("Credential Type")
union CredentialType {
  @doc("The GoldenGate credential")
  GoldenGate: "GoldenGate",

  @doc("The IAM Credential")
  Iam: "IAM",

  string,
}

@added(Versions.v20251001_preview)
@doc("Deployment Type enum")
union DeploymentType {
  @doc("The Ogg Deployment")
  Ogg: "Ogg",

  @doc("The Oracle Database Deployment")
  DatabaseOracle: ("DatabaseOracle"),

  @doc("The Big Data Deployment")
  BigData: ("BigData"),

  @doc("The Database Microsoft Sql Server Deployment")
  DatabaseMicrosoftSqlServer: ("DatabaseMicrosoftSQLServer"),

  @doc("The Database MySql Deployment")
  DatabaseMySql: ("DatabaseMySQL"),

  @doc("The Database PostGreSQL Deployment")
  PostGreSql: ("PostGreSQL"),

  @doc("The Database DB2ZOS Deployment")
  DatabaseDB2ZOS: ("DatabaseDB2ZOS"),

  @doc("The Database DB2I Deployment")
  DatabaseDB2I: ("DATABASE_DB2I"),

  @doc("The GGSA Deployment")
  Ggsa: ("GGSA"),

  @doc("The Data Transforms Deployment")
  DataTransforms: ("DataTransforms"),

  string,
}

@added(Versions.v20251001_preview)
@doc("Deployment Life Cycle State Enum")
union DeploymentLifecycleState {
  @doc("Indicates that resource in Creating state")
  Creating: "Creating",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Active state")
  Active: "Active",

  @doc("Indicates that resource in InActive state")
  InActive: "InActive",

  @doc("Indicates that resource in Deleting state")
  Deleting: "Deleting",

  @doc("Indicates that resource in Deleted state")
  Deleted: "Deleted",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  @doc("Indicates that resource in NeedsAttention state")
  NeedsAttention: "Needs Attention",

  @doc("Indicates that resource in InProgress state")
  InProgress: "In Progress",

  @doc("Indicates that resource in Canceling state")
  Canceling: "Canceling",

  @doc("Indicates that resource in Canceled state")
  Canceled: "Canceled",

  @doc("Indicates that resource in Succeeded state")
  Succeeded: "Succeeded",

  @doc("Indicates that resource in Waiting state")
  Waiting: "Waiting",

  string,
}

@added(Versions.v20251001_preview)
@doc("Setup Type enum")
union SetupType {
  @doc("Production setup")
  Production: "Production",

  @doc("Development or Testing setup")
  DevelopmentOrTesting: "DevelopmentOrTesting",

  string,
}

@added(Versions.v20251001_preview)
@doc("Frequency Type enum")
union FrequencyType {
  @doc("The Daily Frequency")
  Daily: "Daily",

  @doc("The Weekly Frequency")
  Weekly: "Weekly",

  @doc("The Monthly Frequency")
  Monthly: "Monthly",

  string,
}

@added(Versions.v20251001_preview)
@doc("Backup Schedule Type")
model BackupScheduleType {
  @doc("Bucket Name")
  bucketName?: string;

  @doc("Compartment Id")
  compartmentId?: Ocid;

  @doc("Frequency Backup Schedule")
  frequencyBackupScheduled?: FrequencyType;

  @doc("Is Metadata")
  isMetadataOnly?: boolean;

  @doc("Namespace")
  namespaceName?: string;

  @doc("Time Backup Scheduled")
  timeBackupScheduled?: string;
}

@added(Versions.v20251001_preview)
@doc("Group To Roles Mapping Properties")
model GroupToRolesMappingDetails {
  @doc("The OCID of the IDP group which will be mapped to goldengate role administratorGroup.It grants full access to the user, including the ability to alter general, non-security related operational parameters and profiles of the server.")
  @minLength(0)
  @maxLength(255)
  administratorGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role operatorGroup.It allows users to perform only operational actions, like starting and stopping resources. Operators cannot alter the operational parameters or profiles of the MA server.")
  @minLength(0)
  @maxLength(255)
  operatorGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role securityGroup.It grants administration of security related objects and invoke security related service requests. This role has full privileges.")
  @minLength(0)
  @maxLength(255)
  securityGroupId?: string;

  @doc("The OCID of the IDP group which will be mapped to goldengate role userGroup. It allows information-only service requests, which do not alter or affect the operation of either the MA. Examples of query and read-only information include performance metric information and resource status and monitoring information")
  @minLength(0)
  @maxLength(255)
  userGroupId?: string;

  @doc("The OCID of the Identity Domain when IAM credential store is used.")
  @minLength(1)
  @maxLength(255)
  identityDomainId?: string;

  @doc("The base64 encoded content of the PEM file containing the private key.")
  @minLength(0)
  @maxLength(8192)
  key?: string;

  @doc("Version of OGG")
  @minLength(1)
  oggVersion?: string;

  @doc("The OCID of the Secret where the deployment password is stored.")
  @minLength(1)
  @maxLength(255)
  passwordSecretId?: string;
}

@added(Versions.v20251001_preview)
@doc("All Oracle Golden Gate Deployment Details")
model OggDeploymentDetails {
  @doc("The password associated with the GoldenGate deployment console username. The password must be 8 to 30 characters long and must contain at least 1 uppercase, 1 lowercase, 1 numeric, and 1 special character. Special characters such as '$', '^', or '?' are not allowed.")
  @minLength(1)
  @maxLength(30)
  adminPassword?: string;

  @doc("The GoldenGate deployment console username.")
  @minLength(0)
  @maxLength(512)
  adminUsername?: string;

  @doc("The base64 encoded content of the PEM file containing the SSL certificate.")
  @minLength(0)
  @maxLength(65536)
  certificate?: string;

  @doc("The type of credential store for OGG.")
  credentialStore?: CredentialType;

  @doc("The name given to the GoldenGate service deployment")
  @minLength(1)
  @maxLength(32)
  deploymentName?: string;

  @doc("Defines the IDP Groups to GoldenGate roles mapping.")
  groupToRolesMapping?: GroupToRolesMappingDetails;
}

@added(Versions.v20251001_preview)
@doc("Maintenance Configuration Type")
model MaintenanceConfigurationType {
  @doc("Bundle Release Period")
  bundleReleaseUpgradePeriodInDays?: int32;

  @doc("Interim Release upgrade in Days")
  interimReleaseUpgradePeriodInDays?: int32;

  @doc("Is Release Auto Upgrade Enabled")
  isInterimReleaseAutoUpgradeEnabled?: boolean;

  @doc("Major Release upgrade in Days")
  majorReleaseUpgradePeriodInDays?: int32;

  @doc("Security Patch Upgrade")
  securityPatchUpgradePeriodInDays?: int32;
}

@added(Versions.v20251001_preview)
@doc("Maintenance Window")
model MaintenanceWindowType {
  @doc("The Day of Week")
  day?: DayOfWeekName;

  @doc("Start Time in UTC")
  startHour?: int32;
}
