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

//---------------------------------------------- ElasticLoadBalancingLoadBalancers ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Elastic Load Balancing Load Balancer",
    plural: "Elastic Load Balancing Load Balancers",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "Elastic",
    "Load",
    "Balancing",
    "Load",
    "Balancer"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model ElasticLoadBalancingLoadBalancer
  is TrackedResource<ElasticLoadBalancingLoadBalancerProperties> {
  @doc("Name of ElasticLoadBalancingLoadBalancer")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("elasticLoadBalancingLoadBalancers")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ElasticLoadBalancingLoadBalancer")
model ElasticLoadBalancingLoadBalancerProperties {
  @doc("AWS Properties")
  awsProperties?: AwsElasticLoadBalancingLoadBalancerProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsElasticLoadBalancingLoadBalancer")
model AwsElasticLoadBalancingLoadBalancerProperties {
  @doc("Property accessLoggingPolicy")
  accessLoggingPolicy?: AccessLoggingPolicy;

  @doc("Property appCookieStickinessPolicy")
  @extension("x-ms-identifiers", [])
  appCookieStickinessPolicy?: AppCookieStickinessPolicy[];

  @doc("Property availabilityZones")
  @extension("x-ms-identifiers", [])
  availabilityZones?: string[];

  @doc("Property canonicalHostedZoneName")
  canonicalHostedZoneName?: string;

  @doc("Property canonicalHostedZoneNameID")
  canonicalHostedZoneNameID?: string;

  @doc("Property connectionDrainingPolicy")
  connectionDrainingPolicy?: ConnectionDrainingPolicy;

  @doc("Property connectionSettings")
  connectionSettings?: ConnectionSettings;

  @doc("Property crossZone")
  crossZone?: boolean;

  @doc("Property dnsName")
  dnsName?: string;

  @doc("Property healthCheck")
  healthCheck?: HealthCheck;

  @doc("Property id")
  id?: string;

  @doc("Property instances")
  @extension("x-ms-identifiers", [])
  instances?: string[];

  @doc("Property lbCookieStickinessPolicy")
  @extension("x-ms-identifiers", [])
  lbCookieStickinessPolicy?: LBCookieStickinessPolicy[];

  @doc("Property listeners")
  @extension("x-ms-identifiers", [])
  listeners?: Listeners[];

  @doc("Property loadBalancerName")
  loadBalancerName?: string;

  @doc("Property policies")
  @extension("x-ms-identifiers", [])
  policies?: Policies[];

  @doc("Property scheme")
  scheme?: string;

  @doc("Property securityGroups")
  @extension("x-ms-identifiers", [])
  securityGroups?: string[];

  @doc("Property sourceSecurityGroupGroupName")
  sourceSecurityGroupGroupName?: string;

  @doc("Property sourceSecurityGroupOwnerAlias")
  sourceSecurityGroupOwnerAlias?: string;

  @doc("Property subnets")
  @extension("x-ms-identifiers", [])
  subnets?: string[];

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AccessLoggingPolicy")
model AccessLoggingPolicy {
  @doc("Property emitInterval")
  emitInterval?: int32;

  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property s3BucketName")
  s3BucketName?: string;

  @doc("Property s3BucketPrefix")
  s3BucketPrefix?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of AppCookieStickinessPolicy")
model AppCookieStickinessPolicy {
  @doc("Property cookieName")
  cookieName?: string;

  @doc("Property policyName")
  policyName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConnectionDrainingPolicy")
model ConnectionDrainingPolicy {
  @doc("Property enabled")
  enabled?: boolean;

  @doc("Property timeout")
  timeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConnectionSettings")
model ConnectionSettings {
  @doc("Property idleTimeout")
  idleTimeout?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of HealthCheck")
model HealthCheck {
  @doc("Property healthyThreshold")
  healthyThreshold?: string;

  @doc("Property interval")
  interval?: string;

  @doc("Property target")
  target?: string;

  @doc("Property timeout")
  timeout?: string;

  @doc("Property unhealthyThreshold")
  unhealthyThreshold?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LBCookieStickinessPolicy")
model LBCookieStickinessPolicy {
  @doc("Property cookieExpirationPeriod")
  cookieExpirationPeriod?: string;

  @doc("Property policyName")
  policyName?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Listeners")
model Listeners {
  @doc("Property instancePort")
  instancePort?: string;

  @doc("Property instanceProtocol")
  instanceProtocol?: string;

  @doc("Property loadBalancerPort")
  loadBalancerPort?: string;

  @doc("Property policyNames")
  @extension("x-ms-identifiers", [])
  policyNames?: string[];

  @doc("Property protocol")
  protocol?: string;

  @doc("Property sslCertificateId")
  sslCertificateId?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Policies")
model Policies {
  @doc("Property attributes")
  attributes?: [];

  @doc("Property instancePorts")
  @extension("x-ms-identifiers", [])
  instancePorts?: string[];

  @doc("Property loadBalancerPorts")
  @extension("x-ms-identifiers", [])
  loadBalancerPorts?: string[];

  @doc("Property policyName")
  policyName?: string;

  @doc("Property policyType")
  policyType?: string;
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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ElasticLoadBalancingLoadBalancers {
  get is ArmResourceRead<ElasticLoadBalancingLoadBalancer>;
  @doc("Create a ElasticLoadBalancingLoadBalancer. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ElasticLoadBalancingLoadBalancer>;
  update is ArmCustomPatchAsync<
    ElasticLoadBalancingLoadBalancer,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ElasticLoadBalancingLoadBalancer>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ElasticLoadBalancingLoadBalancer>;
  listByResourceGroup is ArmResourceListByParent<ElasticLoadBalancingLoadBalancer>;
  listBySubscription is ArmListBySubscription<ElasticLoadBalancingLoadBalancer>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::ElasticLoadBalancing::LoadBalancer
//--------------------------------------------------------------------------------------------
