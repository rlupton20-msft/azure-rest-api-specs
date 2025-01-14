import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./connectors.tsp";
import "./dataPreview.tsp";
import "./fetchCdcSchema.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Private.MessagingConnectors Resource Provider management API.")
@armProviderNamespace
@service({
  title: "Private.MessagingConnectors management service",
})
@versioned(Versions)
namespace Private.MessagingConnectors;

@doc("Private.MessagingConnectors api versions.")
enum Versions {
  @doc("2024-12-24-preview version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_12_24_preview: "2024-12-24-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
