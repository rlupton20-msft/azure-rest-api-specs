import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./azurevalidation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.AzureValidation Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.AzureValidation management service",
})
@versioned(Microsoft.AzureValidation.Versions)
namespace Microsoft.AzureValidation;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_04_01_preview: "2024-04-01-preview",
}
