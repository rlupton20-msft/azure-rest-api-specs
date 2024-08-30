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

//---------------------------------------------- CodeBuildSourceCredentials ----------------------------------------------
#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@about({
  displayNames: {
    singular: "Code Build Source Credential",
    plural: "Code Build Source Credentials",
  },
  keywords: ["Microsoft.AwsConnector", "Code", "Build", "Source", "Credential"],
})
@doc("A Microsoft.AwsConnector resource")
model CodeBuildSourceCredential
  is TrackedResource<CodeBuildSourceCredentialProperties> {
  @doc("Name of CodeBuildSourceCredential")
  @pattern("^(?=.{0,259}[^\\s.]$)(?!.*[<>%&\\?/#])")
  @key("name")
  @path
  @segment("codeBuildSourceCredentials")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of CodeBuildSourceCredential")
model CodeBuildSourceCredentialProperties {
  @doc("AWS Properties")
  awsProperties?: AwsCodeBuildSourceCredentialProperties;

  ...AwsCommonProperties;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the property name is defined in aws."
#suppress "@azure-tools/typespec-azure-core/no-unknown" "Supress no-unknown to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Supress arm-no-record to handle the datatype object used in aws"
#suppress "@azure-tools/typespec-azure-core/property-name-conflict" "AWSConnector will not generate SDK. So, supressing this error"
@doc("Definition of awsCodeBuildSourceCredential")
model AwsCodeBuildSourceCredentialProperties {
  @doc("Property authType")
  authType?: string;

  @doc("Property id")
  id?: string;

  @doc("Property serverType")
  serverType?: string;

  @doc("Property token")
  token?: string;

  @doc("Property username")
  username?: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style as the name is defined in aws."
@armResourceOperations
interface CodeBuildSourceCredentials {
  get is ArmResourceRead<CodeBuildSourceCredential>;
  @doc("Create a CodeBuildSourceCredential. Please note that end user resource creation is currently restricted, but it will be enabled in the future.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeBuildSourceCredential>;
  update is ArmCustomPatchAsync<
    CodeBuildSourceCredential,
    Azure.ResourceManager.Foundations.TagsUpdateModel<CodeBuildSourceCredential>
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CodeBuildSourceCredential>;
  listByResourceGroup is ArmResourceListByParent<CodeBuildSourceCredential>;
  listBySubscription is ArmListBySubscription<CodeBuildSourceCredential>;
}

//--------------------------------------------------------------------------------------------
// This TypeSpec was auto genrated by aws2SwaggerMain.js tool
//
// Input used to generate TypeSpec:
// Cloud Control API Type: AWS::CodeBuild::SourceCredential
//--------------------------------------------------------------------------------------------
