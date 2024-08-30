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

//---------------------------------------------- DmsReplicationInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "DMS Replication Instance",
    plural: "DMS Replication Instances",
  },
  keywords: ["Microsoft.AwsConnector", "DMS", "Replication", "Instance"],
})
@doc("A Microsoft.AwsConnector resource")
model DmsReplicationInstance
  is TrackedResource<DmsReplicationInstanceProperties> {
  @doc("Name of DmsReplicationInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("dmsReplicationInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DmsReplicationInstance")
model DmsReplicationInstanceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsDmsReplicationInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsDmsReplicationInstance")
model AwsDmsReplicationInstanceProperties {
  @doc("Property allocatedStorage")
  allocatedStorage?: int32;

  @doc("Property allowMajorVersionUpgrade")
  allowMajorVersionUpgrade?: boolean;

  @doc("Property autoMinorVersionUpgrade")
  autoMinorVersionUpgrade?: boolean;

  @doc("Property availabilityZone")
  availabilityZone?: string;

  @doc("Property engineVersion")
  engineVersion?: string;

  @doc("Property id")
  id?: string;

  @doc("Property kmsKeyId")
  kmsKeyId?: string;

  @doc("Property multiAZ")
  multiAZ?: boolean;

  @doc("Property preferredMaintenanceWindow")
  preferredMaintenanceWindow?: string;

  @doc("Property publiclyAccessible")
  publiclyAccessible?: boolean;

  @doc("Property replicationInstanceClass")
  replicationInstanceClass?: string;

  @doc("Property replicationInstanceIdentifier")
  replicationInstanceIdentifier?: string;

  @doc("Property replicationInstancePrivateIpAddresses")
  replicationInstancePrivateIpAddresses?: string;

  @doc("Property replicationInstancePublicIpAddresses")
  replicationInstancePublicIpAddresses?: string;

  @doc("Property replicationSubnetGroupIdentifier")
  replicationSubnetGroupIdentifier?: string;

  @doc("Property resourceIdentifier")
  resourceIdentifier?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property vpcSecurityGroupIds")
  @extension("x-ms-identifiers", [])
  vpcSecurityGroupIds?: string[];
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
interface DmsReplicationInstances {
  get is ArmResourceRead<DmsReplicationInstance>;
  @doc("Create a DmsReplicationInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DmsReplicationInstance>;
  update is ArmCustomPatchAsync<
    DmsReplicationInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<DmsReplicationInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DmsReplicationInstance>;
  listByResourceGroup is ArmResourceListByParent<DmsReplicationInstance>;
  listBySubscription is ArmListBySubscription<DmsReplicationInstance>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::DMS::ReplicationInstance
//--------------------------------------------------------------------------------------------
