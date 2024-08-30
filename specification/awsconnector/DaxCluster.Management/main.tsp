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

//---------------------------------------------- DaxClusters ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "DAX Cluster",
    plural: "DAX Clusters",
  },
  keywords: ["Microsoft.AwsConnector", "DAX", "Cluster"],
})
@doc("A Microsoft.AwsConnector resource")
model DaxCluster is TrackedResource<DaxClusterProperties> {
  @doc("Name of DaxCluster")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("daxClusters")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DaxCluster")
model DaxClusterProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDaxClusterProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDaxCluster")
model AwsDaxClusterProperties {
  @doc("Property arn")
  arn?: string;

  @doc("Property availabilityZones")
  @extension("x-ms-identifiers", [])
  availabilityZones?: string[];

  @doc("Property clusterDiscoveryEndpoint")
  clusterDiscoveryEndpoint?: string;

  @doc("Property clusterDiscoveryEndpointURL")
  clusterDiscoveryEndpointURL?: string;

  @doc("Property clusterEndpointEncryptionType")
  clusterEndpointEncryptionType?: string;

  @doc("Property clusterName")
  clusterName?: string;

  @doc("Property description")
  description?: string;

  @doc("Property iamRoleARN")
  iamRoleARN?: string;

  @doc("Property id")
  id?: string;

  @doc("Property nodeType")
  nodeType?: string;

  @doc("Property notificationTopicARN")
  notificationTopicARN?: string;

  @doc("Property parameterGroupName")
  parameterGroupName?: string;

  @doc("Property preferredMaintenanceWindow")
  preferredMaintenanceWindow?: string;

  @doc("Property replicationFactor")
  replicationFactor?: int32;

  @doc("Property sseSpecification")
  sseSpecification?: SSESpecification;

  @doc("Property securityGroupIds")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Property subnetGroupName")
  subnetGroupName?: string;

  @doc("Property tags")
  tags?: unknown;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SSESpecification")
model SSESpecification {
  @doc("Property sseEnabled")
  sseEnabled?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface DaxClusters {
  get is ArmResourceRead<DaxCluster>;
  @doc("Create a DaxCluster. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DaxCluster>;
  update is ArmCustomPatchAsync<
    DaxCluster,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DaxCluster>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DaxCluster>;
  listByResourceGroup is ArmResourceListByParent<DaxCluster>;
  listBySubscription is ArmListBySubscription<DaxCluster>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::DAX::Cluster
//--------------------------------------------------------------------------------------------
