import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./assets.tsp";
import "./assetEndpointProfiles.tsp";
import "./devices.tsp";
import "./billings.tsp";
import "./discoveredAssets.tsp";
import "./discoveredAssetEndpointProfiles.tsp";
import "./schemaRegistries.tsp";
import "./namespaces.tsp";
import "./credential.tsp";
import "./policy.tsp";
import "./ns_devices.tsp";
import "./ns_assets.tsp";
import "./ns_discoveredAssets.tsp";
import "./ns_discoveredDevices.tsp";
import "./ns_assetEndpointProfiles.tsp";
import "./ns_discoveredAssetEndpointProfiles.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service(#{ title: "Private.DeviceRegistry management service" })
@doc("Private.DeviceRegistry Resource Provider management API.")
@versioned(Versions)
namespace Private.DeviceRegistry;

/** API versions */
@doc("Private.DeviceRegistry Resource Provider supported API versions.")
enum Versions {
  @doc("Private.DeviceRegistry Resource Provider management API version 2023-11-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_11_01_preview: "2023-11-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-05-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-07-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_07_01_preview: "2024-07-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-09-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_09_01_preview: "2024-09-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-10-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-11-01.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_11_01: "2024-11-01",

  @doc("Private.DeviceRegistry Resource Provider management API version 2025-07-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_07_01_preview: "2025-07-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2025-10-01")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_10_01: "2025-10-01",

  @doc("Private.DeviceRegistry Resource Provider management API version 2025-08-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_08_01_preview: "2025-08-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2025-11-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_11_01_preview: "2025-11-01-preview",

  // Dev API Versions
  // Please add new versions before this line
  @doc("Private.DeviceRegistry Resource Provider management API version 2021-10-10-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2021_10_10_preview: "2021-10-10-preview",
  // DO NOT ADD NEW API VERSIONS HERE
  // ADD NEW VERSIONS BEFORE DEV API VERSIONS
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationStatus {
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy"
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Private.DeviceRegistry",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");