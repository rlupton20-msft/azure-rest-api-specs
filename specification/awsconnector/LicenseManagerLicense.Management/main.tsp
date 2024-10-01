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

//---------------------------------------------- LicenseManagerLicenses ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "License  Manager License",
    plural: "License  Manager Licenses",
  },
  keywords: ["Microsoft.AwsConnector", "License ", "Manager", "License"],
})
@doc("A Microsoft.AwsConnector resource")
model LicenseManagerLicense
  is TrackedResource<LicenseManagerLicenseProperties> {
  @doc("Name of LicenseManagerLicense")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("licenseManagerLicenses")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LicenseManagerLicense")
model LicenseManagerLicenseProperties {
  @doc("AWS Properties")
  awsProperties?: AwsLicenseManagerLicenseProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsLicenseManagerLicense")
model AwsLicenseManagerLicenseProperties {
  @doc("<p>License beneficiary.</p>")
  beneficiary?: string;

  @doc("<p>Configuration for consumption of the license.</p>")
  consumptionConfiguration?: ConsumptionConfiguration;

  @doc("<p>License creation time.</p>")
  createTime?: string;

  @doc("<p>License entitlements.</p>")
  @extension("x-ms-identifiers", [])
  entitlements?: Entitlement[];

  @doc("<p>Home Region of the license.</p>")
  homeRegion?: string;

  @doc("<p>License issuer.</p>")
  issuer?: IssuerDetails;

  @doc("<p>Amazon Resource Name (ARN) of the license.</p>")
  licenseArn?: string;

  @doc("<p>License metadata.</p>")
  @extension("x-ms-identifiers", [])
  licenseMetadata?: Metadata[];

  @doc("<p>License name.</p>")
  licenseName?: string;

  @doc("<p>Product name.</p>")
  productName?: string;

  @doc("<p>Product SKU.</p>")
  productSKU?: string;

  @doc("<p>License status.</p>")
  status?: LicenseStatusEnumValue;

  @doc("<p>Date and time range during which the license is valid, in ISO8601-UTC format.</p>")
  validity?: DatetimeRange;

  @doc("<p>License version.</p>")
  version?: string;
}

@doc("LicenseStatus enum")
union LicenseStatus {
  @doc("LicenseStatus enum AVAILABLE")
  AVAILABLE: "AVAILABLE",

  @doc("LicenseStatus enum DEACTIVATED")
  DEACTIVATED: "DEACTIVATED",

  @doc("LicenseStatus enum DELETED")
  DELETED: "DELETED",

  @doc("LicenseStatus enum EXPIRED")
  EXPIRED: "EXPIRED",

  @doc("LicenseStatus enum PENDING_AVAILABLE")
  PENDING_AVAILABLE: "PENDING_AVAILABLE",

  @doc("LicenseStatus enum PENDING_DELETE")
  PENDING_DELETE: "PENDING_DELETE",

  @doc("LicenseStatus enum SUSPENDED")
  SUSPENDED: "SUSPENDED",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of LicenseStatusEnumValue")
model LicenseStatusEnumValue {
  @doc("Property value")
  value?: LicenseStatus;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ConsumptionConfiguration")
model ConsumptionConfiguration {
  @doc("<p>Details about a borrow configuration.</p>")
  borrowConfiguration?: BorrowConfiguration;

  @doc("<p>Details about a provisional configuration.</p>")
  provisionalConfiguration?: ProvisionalConfiguration;

  @doc("<p>Renewal frequency.</p>")
  renewType?: RenewTypeEnumValue;
}

@doc("RenewType enum")
union RenewType {
  @doc("RenewType enum Monthly")
  Monthly: "Monthly",

  @doc("RenewType enum None")
  None: "None",

  @doc("RenewType enum Weekly")
  Weekly: "Weekly",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of RenewTypeEnumValue")
model RenewTypeEnumValue {
  @doc("Property value")
  value?: RenewType;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Entitlement")
model Entitlement {
  @doc("<p>Indicates whether check-ins are allowed.</p>")
  allowCheckIn?: boolean;

  @doc("<p>Maximum entitlement count. Use if the unit is not None.</p>")
  maxCount?: int64;

  @doc("<p>Entitlement name.</p>")
  name?: string;

  @doc("<p>Indicates whether overages are allowed.</p>")
  overage?: boolean;

  @doc("<p>Entitlement unit.</p>")
  unit?: EntitlementUnitEnumValue;

  @doc("<p>Entitlement resource. Use only if the unit is None.</p>")
  value?: string;
}

@doc("EntitlementUnit enum")
union EntitlementUnit {
  @doc("EntitlementUnit enum Bits")
  Bits: "Bits",

  @doc("EntitlementUnit enum Bits/Second")
  BitsSecond: "Bits/Second",

  @doc("EntitlementUnit enum Bytes")
  Bytes: "Bytes",

  @doc("EntitlementUnit enum Bytes/Second")
  BytesSecond: "Bytes/Second",

  @doc("EntitlementUnit enum Count")
  Count: "Count",

  @doc("EntitlementUnit enum Count/Second")
  CountSecond: "Count/Second",

  @doc("EntitlementUnit enum Gigabits")
  Gigabits: "Gigabits",

  @doc("EntitlementUnit enum Gigabits/Second")
  GigabitsSecond: "Gigabits/Second",

  @doc("EntitlementUnit enum Gigabytes")
  Gigabytes: "Gigabytes",

  @doc("EntitlementUnit enum Gigabytes/Second")
  GigabytesSecond: "Gigabytes/Second",

  @doc("EntitlementUnit enum Kilobits")
  Kilobits: "Kilobits",

  @doc("EntitlementUnit enum Kilobits/Second")
  KilobitsSecond: "Kilobits/Second",

  @doc("EntitlementUnit enum Kilobytes")
  Kilobytes: "Kilobytes",

  @doc("EntitlementUnit enum Kilobytes/Second")
  KilobytesSecond: "Kilobytes/Second",

  @doc("EntitlementUnit enum Megabits")
  Megabits: "Megabits",

  @doc("EntitlementUnit enum Megabits/Second")
  MegabitsSecond: "Megabits/Second",

  @doc("EntitlementUnit enum Megabytes")
  Megabytes: "Megabytes",

  @doc("EntitlementUnit enum Megabytes/Second")
  MegabytesSecond: "Megabytes/Second",

  @doc("EntitlementUnit enum Microseconds")
  Microseconds: "Microseconds",

  @doc("EntitlementUnit enum Milliseconds")
  Milliseconds: "Milliseconds",

  @doc("EntitlementUnit enum None")
  None: "None",

  @doc("EntitlementUnit enum Percent")
  Percent: "Percent",

  @doc("EntitlementUnit enum Seconds")
  Seconds: "Seconds",

  @doc("EntitlementUnit enum Terabits")
  Terabits: "Terabits",

  @doc("EntitlementUnit enum Terabits/Second")
  TerabitsSecond: "Terabits/Second",

  @doc("EntitlementUnit enum Terabytes")
  Terabytes: "Terabytes",

  @doc("EntitlementUnit enum Terabytes/Second")
  TerabytesSecond: "Terabytes/Second",

  string,
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of EntitlementUnitEnumValue")
model EntitlementUnitEnumValue {
  @doc("Property value")
  value?: EntitlementUnit;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of IssuerDetails")
model IssuerDetails {
  @doc("<p>Issuer key fingerprint.</p>")
  keyFingerprint?: string;

  @doc("<p>Issuer name.</p>")
  name?: string;

  @doc("<p>Asymmetric KMS key from Key Management Service. The KMS key must have a key usage of sign and verify, and support the RSASSA-PSS SHA-256 signing algorithm.</p>")
  signKey?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of Metadata")
model Metadata {
  @doc("<p>The key name.</p>")
  name?: string;

  @doc("<p>The value.</p>")
  value?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DatetimeRange")
model DatetimeRange {
  @doc("<p>Start of the time range.</p>")
  begin?: string;

  @doc("<p>End of the time range.</p>")
  end?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of BorrowConfiguration")
model BorrowConfiguration {
  @doc("<p>Indicates whether early check-ins are allowed.</p>")
  allowEarlyCheckIn?: boolean;

  @doc("<p>Maximum time for the borrow configuration, in minutes.</p>")
  maxTimeToLiveInMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of ProvisionalConfiguration")
model ProvisionalConfiguration {
  @doc("<p>Maximum time for the provisional configuration, in minutes.</p>")
  maxTimeToLiveInMinutes?: int32;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface LicenseManagerLicenses {
  get is ArmResourceRead<LicenseManagerLicense>;
  @doc("Create a LicenseManagerLicense. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<LicenseManagerLicense>;
  update is ArmCustomPatchAsync<
    LicenseManagerLicense,
    Azure.ResourceManager.Foundations.TagsUpdateModel<LicenseManagerLicense>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<LicenseManagerLicense>;
  listByResourceGroup is ArmResourceListByParent<LicenseManagerLicense>;
  listBySubscription is ArmListBySubscription<LicenseManagerLicense>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// AWS Service Model: generator\ServiceModels\license-manager\license-manager-2018-08-01.normal.json
// AWS Shape: License
//
// Related information for backend service:
// AWS Servcie : License Manager
// Product Version : 3.7.798.0
// SDK Version : 3.7.300.83
//--------------------------------------------------------------------------------------------
