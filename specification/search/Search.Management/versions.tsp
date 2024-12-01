import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Search;

@doc("Supported API versions.")
enum Versions {
  @doc("API version 2023-05-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_05_01_Preview: "2023-05-01-preview",

  @doc("API version 2023-11-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_11_01_Preview: "2023-11-01-preview"
}