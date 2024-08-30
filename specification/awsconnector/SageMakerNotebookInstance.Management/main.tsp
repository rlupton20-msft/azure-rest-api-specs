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

//---------------------------------------------- SageMakerNotebookInstances ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Sage Maker Notebook Instance",
    plural: "Sage Maker Notebook Instances",
  },
  keywords: ["Microsoft.AwsConnector", "Sage", "Maker", "Notebook", "Instance"],
})
@doc("A Microsoft.AwsConnector resource")
model SageMakerNotebookInstance
  is TrackedResource<SageMakerNotebookInstanceProperties> {
  @doc("Name of SageMakerNotebookInstance")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("sageMakerNotebookInstances")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of SageMakerNotebookInstance")
model SageMakerNotebookInstanceProperties {
  @doc("AWS Properties")
  awsProperties?: AwsSageMakerNotebookInstanceProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsSageMakerNotebookInstance")
model AwsSageMakerNotebookInstanceProperties {
  @doc("Property acceleratorTypes")
  @extension("x-ms-identifiers", [])
  acceleratorTypes?: string[];

  @doc("Property additionalCodeRepositories")
  @extension("x-ms-identifiers", [])
  additionalCodeRepositories?: string[];

  @doc("Property defaultCodeRepository")
  defaultCodeRepository?: string;

  @doc("Property directInternetAccess")
  directInternetAccess?: string;

  @doc("Property id")
  id?: string;

  @doc("Property instanceMetadataServiceConfiguration")
  instanceMetadataServiceConfiguration?: InstanceMetadataServiceConfiguration;

  @doc("Property instanceType")
  instanceType?: string;

  @doc("Property kmsKeyId")
  kmsKeyId?: string;

  @doc("Property lifecycleConfigName")
  lifecycleConfigName?: string;

  @doc("Property notebookInstanceName")
  notebookInstanceName?: string;

  @doc("Property platformIdentifier")
  platformIdentifier?: string;

  @doc("Property roleArn")
  roleArn?: string;

  @doc("Property rootAccess")
  rootAccess?: string;

  @doc("Property securityGroupIds")
  @extension("x-ms-identifiers", [])
  securityGroupIds?: string[];

  @doc("Property subnetId")
  subnetId?: string;

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property volumeSizeInGB")
  volumeSizeInGB?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of InstanceMetadataServiceConfiguration")
model InstanceMetadataServiceConfiguration {
  @doc("Property minimumInstanceMetadataServiceVersion")
  minimumInstanceMetadataServiceVersion?: string;
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
interface SageMakerNotebookInstances {
  get is ArmResourceRead<SageMakerNotebookInstance>;
  @doc("Create a SageMakerNotebookInstance. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SageMakerNotebookInstance>;
  update is ArmCustomPatchAsync<
    SageMakerNotebookInstance,
    Azure.ResourceManager.Foundations.TagsUpdateModel<SageMakerNotebookInstance>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SageMakerNotebookInstance>;
  listByResourceGroup is ArmResourceListByParent<SageMakerNotebookInstance>;
  listBySubscription is ArmListBySubscription<SageMakerNotebookInstance>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::SageMaker::NotebookInstance
//--------------------------------------------------------------------------------------------
