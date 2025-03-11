import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./hl7edgeconnector.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@doc("Private HealthcareInteropDev Edge resources management API.")
@armProviderNamespace("Private.HealthcareInteropDev")
@service({
  title: "Private HealthcareInteropDev Edge service",
})
@versioned(Versions)
namespace Private.HealthcareInteropDev;

/** HealthcareInterop API versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("The 2025-05-01-preview version.")
  v2025_05_01_preview: "2025-05-01-preview",
}

/** The provisioning state of a resource. */
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is being Deleted */
  Deleting: "Deleting",
}
@doc("The error acknowledgment strategy.")
union ErrorAckStrategy {
  string,

  /** The error acknowledgment strategy is to send a negative acknowledgment (NACK) message */
  SendNackOnError: "SendNackOnError",

  /** The error acknowledgment strategy is to never send a negative acknowledgment (NACK) message */
  NeverSendNack: "NeverSendNack",
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
