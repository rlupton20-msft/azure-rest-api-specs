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

//---------------------------------------------- AppSyncGraphQLApis ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "App Sync Graph QLApi",
    plural: "App Sync Graph QLApis",
  },
  keywords: ["Microsoft.AwsConnector", "App", "Sync", "Graph", "QLApi"],
})
@doc("A Microsoft.AwsConnector resource")
model AppSyncGraphQLApi is TrackedResource<AppSyncGraphQLApiProperties> {
  @doc("Name of AppSyncGraphQLApi")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("appSyncGraphQLApis")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AppSyncGraphQLApi")
model AppSyncGraphQLApiProperties {
  @doc("AWS Properties")
  awsProperties?: AwsAppSyncGraphQLApiProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsAppSyncGraphQLApi")
model AwsAppSyncGraphQLApiProperties {
  @doc("Property additionalAuthenticationProviders")
  @extension("x-ms-identifiers", [])
  additionalAuthenticationProviders?: AdditionalAuthenticationProvider[];

  @doc("Property apiId")
  apiId?: string;

  @doc("Property apiType")
  apiType?: string;

  @doc("Property arn")
  arn?: string;

  @doc("Property authenticationType")
  authenticationType?: string;

  @doc("Property enhancedMetricsConfig")
  enhancedMetricsConfig?: EnhancedMetricsConfig;

  @doc("Property environmentVariables")
  environmentVariables?: unknown;

  @doc("Property graphQLDns")
  graphQLDns?: string;

  @doc("Property graphQLEndpointArn")
  graphQLEndpointArn?: string;

  @doc("Property graphQLUrl")
  graphQLUrl?: string;

  @doc("Property id")
  id?: string;

  @doc("Property introspectionConfig")
  introspectionConfig?: string;

  @doc("Property lambdaAuthorizerConfig")
  lambdaAuthorizerConfig?: LambdaAuthorizerConfig;

  @doc("Property logConfig")
  logConfig?: LogConfig;

  @doc("Property mergedApiExecutionRoleArn")
  mergedApiExecutionRoleArn?: string;

  @doc("Property name")
  name?: string;

  @doc("Property openIDConnectConfig")
  openIDConnectConfig?: OpenIDConnectConfig;

  @doc("Property ownerContact")
  ownerContact?: string;

  @doc("Property queryDepthLimit")
  queryDepthLimit?: int32;

  @doc("Property realtimeDns")
  realtimeDns?: string;

  @doc("Property realtimeUrl")
  realtimeUrl?: string;

  @doc("Property resolverCountLimit")
  resolverCountLimit?: int32;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property userPoolConfig")
  userPoolConfig?: UserPoolConfig;

  @doc("Property visibility")
  visibility?: string;

  @doc("Property xrayEnabled")
  xrayEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AdditionalAuthenticationProvider")
model AdditionalAuthenticationProvider {
  @doc("Property authenticationType")
  authenticationType?: string;

  @doc("Property lambdaAuthorizerConfig")
  lambdaAuthorizerConfig?: LambdaAuthorizerConfig;

  @doc("Property openIDConnectConfig")
  openIDConnectConfig?: OpenIDConnectConfig;

  @doc("Property userPoolConfig")
  userPoolConfig?: CognitoUserPoolConfig;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EnhancedMetricsConfig")
model EnhancedMetricsConfig {
  @doc("Property dataSourceLevelMetricsBehavior")
  dataSourceLevelMetricsBehavior?: string;

  @doc("Property operationLevelMetricsConfig")
  operationLevelMetricsConfig?: string;

  @doc("Property resolverLevelMetricsBehavior")
  resolverLevelMetricsBehavior?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LambdaAuthorizerConfig")
model LambdaAuthorizerConfig {
  @doc("Property authorizerResultTtlInSeconds")
  authorizerResultTtlInSeconds?: int32;

  @doc("Property authorizerUri")
  authorizerUri?: string;

  @doc("Property identityValidationExpression")
  identityValidationExpression?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LogConfig")
model LogConfig {
  @doc("Property cloudWatchLogsRoleArn")
  cloudWatchLogsRoleArn?: string;

  @doc("Property excludeVerboseContent")
  excludeVerboseContent?: boolean;

  @doc("Property fieldLogLevel")
  fieldLogLevel?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of OpenIDConnectConfig")
model OpenIDConnectConfig {
  @doc("Property authTTL")
  authTTL?: int32;

  @doc("Property clientId")
  clientId?: string;

  @doc("Property iatTTL")
  iatTTL?: int32;

  @doc("Property issuer")
  issuer?: string;
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
@doc("Definition of UserPoolConfig")
model UserPoolConfig {
  @doc("Property appIdClientRegex")
  appIdClientRegex?: string;

  @doc("Property awsRegion")
  awsRegion?: string;

  @doc("Property defaultAction")
  defaultAction?: string;

  @doc("Property userPoolId")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CognitoUserPoolConfig")
model CognitoUserPoolConfig {
  @doc("Property appIdClientRegex")
  appIdClientRegex?: string;

  @doc("Property awsRegion")
  awsRegion?: string;

  @doc("Property userPoolId")
  userPoolId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface AppSyncGraphQLApis {
  get is ArmResourceRead<AppSyncGraphQLApi>;
  @doc("Create a AppSyncGraphQLApi. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppSyncGraphQLApi>;
  update is ArmCustomPatchAsync<
    AppSyncGraphQLApi,
    Azure.ResourceManager.Foundations.TagsUpdateModel<AppSyncGraphQLApi>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AppSyncGraphQLApi>;
  listByResourceGroup is ArmResourceListByParent<AppSyncGraphQLApi>;
  listBySubscription is ArmListBySubscription<AppSyncGraphQLApi>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::AppSync::GraphQLApi
//--------------------------------------------------------------------------------------------
