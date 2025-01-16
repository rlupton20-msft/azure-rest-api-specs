import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./acstorconfiguration.tsp";
import "./edgeingestpolicy.tsp";
import "./edgestorageconfiguration.tsp";
import "./edgesubvolume.tsp";
import "./edgevolume.tsp";
import "./syncsubvolume.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Private.ArcContainerStorage management service",
})
@doc("Private.ArcContainerStorage Resource Provider management API.")
@versioned(Versions)
namespace Private.ArcContainerStorage;

/** API versions */
@doc("Private.ArcContainerStorage Resource Provider supported API versions.")
enum Versions {
  @doc("Private.ArcContainerStorage Resource Provider management API version 2023-11-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2024_10_01_preview: "2024-10-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Private.ArcContainerStorage",

    ...LocationParameter,
    ...Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
