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

//---------------------------------------------- ConfigDeliveryChannels ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Config Delivery Channel",
    plural: "Config Delivery Channels",
  },
  keywords: ["Microsoft.AwsConnector", "Config", "Delivery", "Channel"],
})
@doc("A Microsoft.AwsConnector resource")
model ConfigDeliveryChannel
  is TrackedResource<ConfigDeliveryChannelProperties> {
  @doc("Name of ConfigDeliveryChannel")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("configDeliveryChannels")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigDeliveryChannel")
model ConfigDeliveryChannelProperties {
  @doc("AWS Properties")
  awsProperties?: AwsConfigDeliveryChannelProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsConfigDeliveryChannel")
model AwsConfigDeliveryChannelProperties {
  @doc("Property configSnapshotDeliveryProperties")
  configSnapshotDeliveryProperties?: ConfigSnapshotDeliveryProperties;

  @doc("Property id")
  id?: string;

  @doc("Property name")
  name?: string;

  @doc("Property s3BucketName")
  s3BucketName?: string;

  @doc("Property s3KeyPrefix")
  s3KeyPrefix?: string;

  @doc("Property s3KmsKeyArn")
  s3KmsKeyArn?: string;

  @doc("Property snsTopicARN")
  snsTopicARN?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConfigSnapshotDeliveryProperties")
model ConfigSnapshotDeliveryProperties {
  @doc("Property deliveryFrequency")
  deliveryFrequency?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface ConfigDeliveryChannels {
  get is ArmResourceRead<ConfigDeliveryChannel>;
  @doc("Create a ConfigDeliveryChannel. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ConfigDeliveryChannel>;
  update is ArmCustomPatchAsync<
    ConfigDeliveryChannel,
    Azure.ResourceManager.Foundations.TagsUpdateModel<ConfigDeliveryChannel>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ConfigDeliveryChannel>;
  listByResourceGroup is ArmResourceListByParent<ConfigDeliveryChannel>;
  listBySubscription is ArmListBySubscription<ConfigDeliveryChannel>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::Config::DeliveryChannel
//--------------------------------------------------------------------------------------------
