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

//---------------------------------------------- S3ControlMultiRegionAccessPointReports ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "S3  Control Multi Region Access Point Report",
    plural: "S3  Control Multi Region Access Point Reports",
  },
  keywords: [
    "Microsoft.AwsConnector",
    "S3 ",
    "Control",
    "Multi",
    "Region",
    "Access",
    "Point",
    "Report"
  ],
})
@doc("A Microsoft.AwsConnector resource")
model S3ControlMultiRegionAccessPointReport
  is TrackedResource<S3ControlMultiRegionAccessPointReportProperties> {
  @doc("Name of S3ControlMultiRegionAccessPointReport")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("s3ControlMultiRegionAccessPointReports")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of S3ControlMultiRegionAccessPointReport")
model S3ControlMultiRegionAccessPointReportProperties {
  @doc("AWS Properties")
  awsProperties?: AwsS3ControlMultiRegionAccessPointReportProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsS3ControlMultiRegionAccessPointReport")
model AwsS3ControlMultiRegionAccessPointReportProperties {
  @doc("<p>The alias for the Multi-Region Access Point. For more information about the distinction between the name and the alias of an Multi-Region Access Point, see <a href='https://docs.aws.amazon.com/AmazonS3/latest/userguide/CreatingMultiRegionAccessPoints.html#multi-region-access-point-naming'>Rules for naming Amazon S3 Multi-Region Access Points</a>.</p>")
  `alias`?: string;

  @doc("<p>When the Multi-Region Access Point create request was received.</p>")
  createdAt?: utcDateTime;

  @doc("<p>The name of the Multi-Region Access Point.</p>")
  name?: string;

  @doc("Property publicAccessBlock")
  publicAccessBlock?: PublicAccessBlockConfiguration;

  @doc("<p>A collection of the Regions and buckets associated with the Multi-Region Access Point.</p>")
  @extension("x-ms-identifiers", [])
  regions?: RegionReport[];

  @doc("<p>The current status of the Multi-Region Access Point.</p> <p> <code>CREATING</code> and <code>DELETING</code> are temporary states that exist while the request is propagating and being completed. If a Multi-Region Access Point has a status of <code>PARTIALLY_CREATED</code>, you can retry creation or send a request to delete the Multi-Region Access Point. If a Multi-Region Access Point has a status of <code>PARTIALLY_DELETED</code>, you can retry a delete request to finish the deletion of the Multi-Region Access Point.</p>")
  status?: MultiRegionAccessPointStatusEnumValue;
}

@doc("MultiRegionAccessPointStatus enum")
union MultiRegionAccessPointStatus {
  @doc("MultiRegionAccessPointStatus enum CREATING")
  CREATING: "CREATING",

  @doc("MultiRegionAccessPointStatus enum DELETING")
  DELETING: "DELETING",

  @doc("MultiRegionAccessPointStatus enum INCONSISTENT_ACROSS_REGIONS")
  INCONSISTENT_ACROSS_REGIONS: "INCONSISTENT_ACROSS_REGIONS",

  @doc("MultiRegionAccessPointStatus enum PARTIALLY_CREATED")
  PARTIALLY_CREATED: "PARTIALLY_CREATED",

  @doc("MultiRegionAccessPointStatus enum PARTIALLY_DELETED")
  PARTIALLY_DELETED: "PARTIALLY_DELETED",

  @doc("MultiRegionAccessPointStatus enum READY")
  READY: "READY",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of MultiRegionAccessPointStatusEnumValue")
model MultiRegionAccessPointStatusEnumValue {
  @doc("Property value")
  value?: MultiRegionAccessPointStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of PublicAccessBlockConfiguration")
model PublicAccessBlockConfiguration {
  @doc("<p>Specifies whether Amazon S3 should block public access control lists (ACLs) for buckets in this account. Setting this element to <code>TRUE</code> causes the following behavior:</p> <ul> <li> <p> <code>PutBucketAcl</code> and <code>PutObjectAcl</code> calls fail if the specified ACL is public.</p> </li> <li> <p>PUT Object calls fail if the request includes a public ACL.</p> </li> <li> <p>PUT Bucket calls fail if the request includes a public ACL.</p> </li> </ul> <p>Enabling this setting doesn't affect existing policies or ACLs.</p> <p>This property is not supported for Amazon S3 on Outposts.</p>")
  blockPublicAcls?: boolean;

  @doc("<p>Specifies whether Amazon S3 should block public bucket policies for buckets in this account. Setting this element to <code>TRUE</code> causes Amazon S3 to reject calls to PUT Bucket policy if the specified bucket policy allows public access. </p> <p>Enabling this setting doesn't affect existing bucket policies.</p> <p>This property is not supported for Amazon S3 on Outposts.</p>")
  blockPublicPolicy?: boolean;

  @doc("<p>Specifies whether Amazon S3 should ignore public ACLs for buckets in this account. Setting this element to <code>TRUE</code> causes Amazon S3 to ignore all public ACLs on buckets in this account and any objects that they contain. </p> <p>Enabling this setting doesn't affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set.</p> <p>This property is not supported for Amazon S3 on Outposts.</p>")
  ignorePublicAcls?: boolean;

  @doc("<p>Specifies whether Amazon S3 should restrict public bucket policies for buckets in this account. Setting this element to <code>TRUE</code> restricts access to buckets with public policies to only Amazon Web Service principals and authorized users within this account.</p> <p>Enabling this setting doesn't affect previously stored bucket policies, except that public and cross-account access within any public bucket policy, including non-public delegation to specific accounts, is blocked.</p> <p>This property is not supported for Amazon S3 on Outposts.</p>")
  restrictPublicBuckets?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RegionReport")
model RegionReport {
  @doc("<p>The name of the bucket.</p>")
  bucket?: string;

  @doc("<p>The Amazon Web Services account ID that owns the Amazon S3 bucket that's associated with this Multi-Region Access Point.</p>")
  bucketAccountId?: string;

  @doc("<p>The name of the Region.</p>")
  region?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface S3ControlMultiRegionAccessPointReports {
  get is ArmResourceRead<S3ControlMultiRegionAccessPointReport>;
  @doc("Create a S3ControlMultiRegionAccessPointReport. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<S3ControlMultiRegionAccessPointReport>;
  update is ArmCustomPatchAsync<
    S3ControlMultiRegionAccessPointReport,
    Azure.ResourceManager.Foundations.TagsUpdateModel<S3ControlMultiRegionAccessPointReport>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<S3ControlMultiRegionAccessPointReport>;
  listByResourceGroup is ArmResourceListByParent<S3ControlMultiRegionAccessPointReport>;
  listBySubscription is ArmListBySubscription<S3ControlMultiRegionAccessPointReport>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\s3control\s3control-2018-08-20.normal.json
// AWS Shape: MultiRegionAccessPointReport
//
// Related information for backend service:
// AWS Servcie : S3 Control
// Product Version : 3.7.798.0
// SDK Version : 3.7.305.48
//--------------------------------------------------------------------------------------------
