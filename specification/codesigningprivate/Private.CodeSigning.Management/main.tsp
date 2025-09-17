import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CodeSigningAccount.tsp";
import "./CertificateProfile.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Code Signing resource provider api.")
@armProviderNamespace("Private.CodeSigning")
@service(#{ title: "PrivateCodeSigningManagementClient" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.CodeSigning;

@doc("The available API versions.")
enum Versions {
  @doc("The 2025-08-15-preview API version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2025_07_15_preview: "2025-08-15-preview",
}
