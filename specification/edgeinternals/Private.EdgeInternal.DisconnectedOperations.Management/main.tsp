import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "./images.tsp";
import "./artifacts.tsp";
import "./hardwareSettings.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@versioned(Versions)
@doc("Disconnected operations service API.")
@armCommonTypesVersion(CommonTypes.Versions.v6)
namespace Private.EdgeInternal;

@doc("The available API versions.")
enum Versions {
  @doc("Version 2024-02-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01: "2024-02-01-preview",

  @doc("Version 2024-11-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_11_01: "2024-11-01-preview",

  @doc("Version 2024-12-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_12_01: "2024-12-01-preview",

  @doc("Version 2025-05-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_05_01: "2025-05-01-preview",

  @doc("Version 2025-08-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_08_01: "2025-08-01-preview",
}
