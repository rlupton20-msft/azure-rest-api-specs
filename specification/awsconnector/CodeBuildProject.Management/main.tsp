import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-portal-core";
import "../shared/main.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Azure.Core;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using Azure.Portal;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Supress missing operations endpoint as the same is defined ../operations/main.tsp."
@armProviderNamespace
@service({
  title: "Microsoft.AwsConnector",
})
@doc("Microsoft.AwsConnector Resource Provider management API.")
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AwsConnector;

/** Api versions */
enum Versions {
  /** 2024-12-01 api version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2024-12-01`,
}

//---------------------------------------------- CodeBuildProjects ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Code Build Project",
    plural: "Code Build Projects",
  },
  keywords: ["Microsoft.AwsConnector", "Code", "Build", "Project"],
})
@doc("A Microsoft.AwsConnector resource")
model CodeBuildProject is TrackedResource<CodeBuildProjectProperties> {
  @doc("Name of CodeBuildProject")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("codeBuildProjects")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CodeBuildProject")
model CodeBuildProjectProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCodeBuildProjectProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCodeBuildProject")
model AwsCodeBuildProjectProperties {
  @doc("Property arn")
  arn?: string;

  @doc("Property artifacts")
  artifacts?: Artifacts;

  @doc("Property badgeEnabled")
  badgeEnabled?: boolean;

  @doc("Property buildBatchConfig")
  buildBatchConfig?: ProjectBuildBatchConfig;

  @doc("Property cache")
  cache?: ProjectCache;

  @doc("Property concurrentBuildLimit")
  concurrentBuildLimit?: int32;

  @doc("Property description")
  description?: string;

  @doc("Property encryptionKey")
  encryptionKey?: string;

  @doc("Property environment")
  environment?: Environment;

  @doc("Property fileSystemLocations")
  @extension("x-ms-identifiers", [])
  fileSystemLocations?: ProjectFileSystemLocation[];

  @doc("Property id")
  id?: string;

  @doc("Property logsConfig")
  logsConfig?: LogsConfig;

  @doc("Property name")
  name?: string;

  @doc("Property queuedTimeoutInMinutes")
  queuedTimeoutInMinutes?: int32;

  @doc("Property resourceAccessRole")
  resourceAccessRole?: string;

  @doc("Property secondaryArtifacts")
  @extension("x-ms-identifiers", [])
  secondaryArtifacts?: Artifacts[];

  @doc("Property secondarySourceVersions")
  @extension("x-ms-identifiers", [])
  secondarySourceVersions?: ProjectSourceVersion[];

  @doc("Property secondarySources")
  @extension("x-ms-identifiers", [])
  secondarySources?: Source[];

  @doc("Property serviceRole")
  serviceRole?: string;

  @doc("Property source")
  source?: Source;

  @doc("Property sourceVersion")
  sourceVersion?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property timeoutInMinutes")
  timeoutInMinutes?: int32;

  @doc("Property triggers")
  triggers?: ProjectTriggers;

  @doc("Property visibility")
  visibility?: string;

  @doc("Property vpcConfig")
  vpcConfig?: VpcConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Artifacts")
model Artifacts {
  @doc("Property artifactIdentifier")
  artifactIdentifier?: string;

  @doc("Property encryptionDisabled")
  encryptionDisabled?: boolean;

  @doc("Property location")
  location?: string;

  @doc("Property name")
  name?: string;

  @doc("Property namespaceType")
  namespaceType?: string;

  @doc("Property overrideArtifactName")
  overrideArtifactName?: boolean;

  @doc("Property packaging")
  packaging?: string;

  @doc("Property path")
  path?: string;

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectBuildBatchConfig")
model ProjectBuildBatchConfig {
  @doc("Property batchReportMode")
  batchReportMode?: string;

  @doc("Property combineArtifacts")
  combineArtifacts?: boolean;

  @doc("Property restrictions")
  restrictions?: BatchRestrictions;

  @doc("Property serviceRole")
  serviceRole?: string;

  @doc("Property timeoutInMins")
  timeoutInMins?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectCache")
model ProjectCache {
  @doc("Property location")
  location?: string;

  @doc("Property modes")
  @extension("x-ms-identifiers", [])
  modes?: string[];

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Environment")
model Environment {
  @doc("Property certificate")
  certificate?: string;

  @doc("Property computeType")
  computeType?: string;

  @doc("Property environmentVariables")
  @extension("x-ms-identifiers", [])
  environmentVariables?: EnvironmentVariable[];

  @doc("Property fleet")
  fleet?: ProjectFleet;

  @doc("Property image")
  image?: string;

  @doc("Property imagePullCredentialsType")
  imagePullCredentialsType?: string;

  @doc("Property privilegedMode")
  privilegedMode?: boolean;

  @doc("Property registryCredential")
  registryCredential?: RegistryCredential;

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectFileSystemLocation")
model ProjectFileSystemLocation {
  @doc("Property identifier")
  identifier?: string;

  @doc("Property location")
  location?: string;

  @doc("Property mountOptions")
  mountOptions?: string;

  @doc("Property mountPoint")
  mountPoint?: string;

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogsConfig")
model LogsConfig {
  @doc("Property cloudWatchLogs")
  cloudWatchLogs?: CloudWatchLogsConfig;

  @doc("Property s3Logs")
  s3Logs?: S3LogsConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectSourceVersion")
model ProjectSourceVersion {
  @doc("Property sourceIdentifier")
  sourceIdentifier?: string;

  @doc("Property sourceVersion")
  sourceVersion?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Source")
model Source {
  @doc("Property auth")
  auth?: SourceAuth;

  @doc("Property buildSpec")
  buildSpec?: string;

  @doc("Property buildStatusConfig")
  buildStatusConfig?: BuildStatusConfig;

  @doc("Property gitCloneDepth")
  gitCloneDepth?: int32;

  @doc("Property gitSubmodulesConfig")
  gitSubmodulesConfig?: GitSubmodulesConfig;

  @doc("Property insecureSsl")
  insecureSsl?: boolean;

  @doc("Property location")
  location?: string;

  @doc("Property reportBuildStatus")
  reportBuildStatus?: boolean;

  @doc("Property sourceIdentifier")
  sourceIdentifier?: string;

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectTriggers")
model ProjectTriggers {
  @doc("Property buildType")
  buildType?: string;

  @doc("Property filterGroups")
  @extension("x-ms-identifiers", [])
  filterGroups?: Record<unknown>[];

  @doc("Property webhook")
  webhook?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of VpcConfig")
model VpcConfig {
  @doc("Property securityGroupIds")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Property subnets")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("Property vpcId")
  vpcId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BatchRestrictions")
model BatchRestrictions {
  @doc("Property computeTypesAllowed")
  @extension("x-ms-identifiers", [])
  computeTypesAllowed?: string[];

  @doc("Property maximumBuildsAllowed")
  maximumBuildsAllowed?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnvironmentVariable")
model EnvironmentVariable {
  @doc("Property name")
  name?: string;

  @doc("Property type")
  type?: string;

  @doc("Property value")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProjectFleet")
model ProjectFleet {
  @doc("Property fleetArn")
  fleetArn?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegistryCredential")
model RegistryCredential {
  @doc("Property credential")
  credential?: string;

  @doc("Property credentialProvider")
  credentialProvider?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CloudWatchLogsConfig")
model CloudWatchLogsConfig {
  @doc("Property groupName")
  groupName?: string;

  @doc("Property status")
  status?: string;

  @doc("Property streamName")
  streamName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3LogsConfig")
model S3LogsConfig {
  @doc("Property encryptionDisabled")
  encryptionDisabled?: boolean;

  @doc("Property location")
  location?: string;

  @doc("Property status")
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SourceAuth")
model SourceAuth {
  @doc("Property resource")
  resource?: string;

  @doc("Property type")
  type?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BuildStatusConfig")
model BuildStatusConfig {
  @doc("Property context")
  context?: string;

  @doc("Property targetUrl")
  targetUrl?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of GitSubmodulesConfig")
model GitSubmodulesConfig {
  @doc("Property fetchSubmodules")
  fetchSubmodules?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CodeBuildProjects {
  get is ArmResourceRead<CodeBuildProject>;
  @doc("Create a CodeBuildProject. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeBuildProject>;
  update is ArmCustomPatchAsync<
    CodeBuildProject,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CodeBuildProject>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CodeBuildProject>;
  listByResourceGroup is ArmResourceListByParent<CodeBuildProject>;
  listBySubscription is ArmListBySubscription<CodeBuildProject>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CodeBuild::Project
//--------------------------------------------------------------------------------------------
