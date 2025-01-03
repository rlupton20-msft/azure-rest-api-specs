import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionTemplateVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Target Template Properties")
model TargetTemplateProperties {
  @doc("Description of Target template")
  description: string;

  @doc("target spec")
  targetSpec: string;

  @doc("Orchestrator Type")
  orchestratorType: OrchestratorType;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Target Template Resource")
model TargetTemplate is TrackedResource<TargetTemplateProperties> {
  ...ResourceNameParameter<TargetTemplate>;
}

@armResourceOperations
interface TargetTemplates {
  @doc("Get a Target Template Resource")
  get is ArmResourceRead<TargetTemplate>;

  @doc("Create or update a Target Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TargetTemplate>;

  @doc("update a Target Template Resource")
  update is ArmResourcePatchSync<TargetTemplate, TargetTemplateProperties>;

  @doc("Delete a Target Template Resource")
  delete is ArmResourceDeleteSync<TargetTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<TargetTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<TargetTemplate>;
}
