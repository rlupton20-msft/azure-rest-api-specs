import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./Configuration.tsp";
import "./DynamicConfiguration.tsp";
import "./DynamicConfigurationVersion.tsp";
import "./ArcGatewayConfiguration.tsp";
import "./TimeServerConfiguration.tsp";
import "./ConnectivityConfiguration.tsp";
import "./NetworkConfiguration.tsp";
import "./SecurityConfiguration.tsp";
import "./ProvisioningConfigurations.tsp";
import "./StaticConfiguration.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** Private.Edge Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@armProviderNamespace
@service(#{ title: "Private.Edge" })
@versioned(Versions)
namespace Private.Edge;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_01: "2025-08-01",
}
