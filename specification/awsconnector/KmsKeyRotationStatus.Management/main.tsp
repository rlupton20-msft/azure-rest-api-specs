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

//---------------------------------------------- KmsKeyRotationStatuses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "KMS Key Rotation Status",
    plural: "KMS Key Rotation Statuses",
  },
  keywords: ["Microsoft.AwsConnector", "KMS", "Key", "Rotation", "Status"],
})
@doc("A Microsoft.AwsConnector resource")
model KmsKeyRotationStatus is TrackedResource<KmsKeyRotationStatusProperties> {
  @doc("Name of KmsKeyRotationStatus")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("kmsKeyRotationStatuses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of KmsKeyRotationStatus")
model KmsKeyRotationStatusProperties {
  @doc("AWS Properties")
  awsProperties?: AwsKmsKeyRotationStatusProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsKmsKeyRotationStatus")
model AwsKmsKeyRotationStatusProperties {
  @doc("<p>Identifies the specified symmetric encryption KMS key.</p>")
  keyId?: string;

  @doc("<p>A Boolean value that specifies whether key rotation is enabled.</p>")
  keyRotationEnabled?: boolean;

  @doc("<p>The next date that KMS will automatically rotate the key material.</p>")
  nextRotationDate?: utcDateTime;

  @doc("<p>Identifies the date and time that an in progress on-demand rotation was initiated.</p> <p>The KMS API follows an <a href='https://docs.aws.amazon.com/kms/latest/developerguide/programming-eventual-consistency.html'>eventual consistency</a> model due to the distributed nature of the system. As a result, there might be a slight delay between initiating on-demand key rotation and the rotation's completion. Once the on-demand rotation is complete, use <a>ListKeyRotations</a> to view the details of the on-demand rotation.</p>")
  onDemandRotationStartDate?: utcDateTime;

  @doc("<p>The number of days between each automatic rotation. The default value is 365 days.</p>")
  rotationPeriodInDays?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface KmsKeyRotationStatuses {
  get is ArmResourceRead<KmsKeyRotationStatus>;
  @doc("Create a KmsKeyRotationStatus. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KmsKeyRotationStatus>;
  update is ArmCustomPatchAsync<
    KmsKeyRotationStatus,
    Azure.ResourceManager.Foundations.TagsUpdateModel<KmsKeyRotationStatus>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<KmsKeyRotationStatus>;
  listByResourceGroup is ArmResourceListByParent<KmsKeyRotationStatus>;
  listBySubscription is ArmListBySubscription<KmsKeyRotationStatus>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\kms\kms-2014-11-01.normal.json
// AWS Shape: KeyRotationStatus
//
// Related information for backend service:
// AWS Servcie : KMS
// Product Version : 3.7.798.0
// SDK Version : 3.7.302.9
//--------------------------------------------------------------------------------------------
