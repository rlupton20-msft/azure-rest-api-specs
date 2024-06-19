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
import "./schemaRegistry.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes.Private;
using Azure.ResourceManager.Private;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Private.DeviceRegistry management service",
})
@doc("Private.DeviceRegistry Resource Provider management API.")
@versioned(global.Private.DeviceRegistry.Versions)
namespace Private.DeviceRegistry;

/** API versions */
@doc("Private.DeviceRegistry Resource Provider supported API versions.")
enum Versions {
  @doc("Private.DeviceRegistry Resource Provider management API version 2023-11-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
  v2023_11_01_preview: "2023-11-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-05-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",

  @doc("Private.DeviceRegistry Resource Provider management API version 2024-07-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_07_01_preview: "2024-07-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  @armUpdateProviderNamespace
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Private.DeviceRegistry",

    ...LocationParameter,

    @path
    @segment("operationStatuses")
    @minLength(1)
    @doc("The ID of an ongoing async operation.")
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v3
    )
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v4
    )
    @armCommonParameter(
      "OperationIdParameter",
      Azure.ResourceManager.CommonTypes.Versions.v5
    )
    operationId: string,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}
