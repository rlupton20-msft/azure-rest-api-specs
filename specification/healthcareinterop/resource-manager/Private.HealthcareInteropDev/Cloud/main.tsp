import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models/hub.tsp";
import "./models/connectors/storageAccountConnector.tsp";
import "./models/connectors/oneLakeConnector.tsp";
import "./models/connectors/hl7Connector.tsp";
import "./models/connectors/ddmsConnector.tsp";
import "./models/connectors/dicomConnector.tsp";
import "./models/channels/dicomDirectChannel.tsp";
import "./models/channels/fhirQueryEventBatchChannel.tsp";
import "./models/channels/fhirQueryFlatFileBatchChannel.tsp";
import "./models/channels/ddmsFhirEventBatchChannel.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@doc("Private HealthcareInteropDev Cloud resources management API.")
@armProviderNamespace("Private.HealthcareInteropDev")
@service(#{ title: "Private HealthcareInteropDev Cloud service" })
@versioned(Versions)
namespace Private.HealthcareInteropDev;

/** HealthcareInterop API versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-05-01-preview version.")
  v2025_05_01_preview: "2025-05-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-06-01-preview version.")
  v2025_06_01_preview: "2025-06-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-07-01-preview version.")
  v2025_07_01_preview: "2025-07-01-preview",
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
    provider: "Private.HealthcareInteropDev",

    ...LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
