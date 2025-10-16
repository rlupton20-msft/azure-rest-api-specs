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
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_06_01_preview: "2024-06-01-preview",

  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01: "2025-08-01",
}
