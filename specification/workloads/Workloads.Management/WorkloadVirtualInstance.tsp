import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Private.Workloads;

/** WorkloadVirtualInstance resource */
model WorkloadVirtualInstance
  is TrackedResource<WorkloadVirtualInstanceProperties> {
  ...ResourceNameParameter<WorkloadVirtualInstance>;
}

@armResourceOperations
interface WorkloadVirtualInstances {
  get is ArmResourceRead<WorkloadVirtualInstance>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadVirtualInstance,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  update is ArmResourcePatchSync<WorkloadVirtualInstance, WorkloadVirtualInstanceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadVirtualInstance>;

  listByResourceGroup is ArmResourceListByParent<WorkloadVirtualInstance>;
  listBySubscription is ArmListBySubscription<WorkloadVirtualInstance>;
}
