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

//---------------------------------------------- CertificateManagerCertificates ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Certificate Manager Certificate",
    plural: "Certificate Manager Certificates",
  },
  keywords: ["Microsoft.AwsConnector", "Certificate", "Manager", "Certificate"],
})
@doc("A Microsoft.AwsConnector resource")
model CertificateManagerCertificate
  is TrackedResource<CertificateManagerCertificateProperties> {
  @doc("Name of CertificateManagerCertificate")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("certificateManagerCertificates")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CertificateManagerCertificate")
model CertificateManagerCertificateProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCertificateManagerCertificateProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCertificateManagerCertificate")
model AwsCertificateManagerCertificateProperties {
  @doc("Property certificateAuthorityArn")
  certificateAuthorityArn?: string;

  @doc("Property certificateTransparencyLoggingPreference")
  certificateTransparencyLoggingPreference?: string;

  @doc("Property domainName")
  domainName?: string;

  @doc("Property domainValidationOptions")
  @extension("x-ms-identifiers", [])
  domainValidationOptions?: DomainValidationOption[];

  @doc("Property id")
  id?: string;

  @doc("Property keyAlgorithm")
  keyAlgorithm?: string;

  @doc("Property subjectAlternativeNames")
  @extension("x-ms-identifiers", [])
  subjectAlternativeNames?: string[];

  @doc("Property tags")
  @extension("x-ms-identifiers", [])
  tags?: Tag[];

  @doc("Property validationMethod")
  validationMethod?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of DomainValidationOption")
model DomainValidationOption {
  @doc("Property domainName")
  domainName?: string;

  @doc("Property hostedZoneId")
  hostedZoneId?: string;

  @doc("Property validationDomain")
  validationDomain?: string;
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
interface CertificateManagerCertificates {
  get is ArmResourceRead<CertificateManagerCertificate>;
  @doc("Create a CertificateManagerCertificate. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CertificateManagerCertificate>;
  update is ArmCustomPatchAsync<
    CertificateManagerCertificate,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CertificateManagerCertificate>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CertificateManagerCertificate>;
  listByResourceGroup is ArmResourceListByParent<CertificateManagerCertificate>;
  listBySubscription is ArmListBySubscription<CertificateManagerCertificate>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CertificateManager::Certificate
//--------------------------------------------------------------------------------------------
