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

/** WorkloadResourceDefinition resource */
model WorkloadResourceDefinition
  is TrackedResource<WorkloadResourceDefinitionProperties> {
  ...ResourceNameParameter<WorkloadResourceDefinition>;
}

@armResourceOperations
interface WorkloadResourceDefinitions {
  get is ArmResourceRead<WorkloadResourceDefinition>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    WorkloadResourceDefinition,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  update is ArmCustomPatchSync<WorkloadResourceDefinition>;
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadResourceDefinition>;

  listByResourceGroup is ArmResourceListByParent<WorkloadResourceDefinition>;
  listBySubscription is ArmListBySubscription<WorkloadResourceDefinition>;
}
