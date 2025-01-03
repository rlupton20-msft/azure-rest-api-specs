import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Solution Template Properties")
model SolutionTemplateProperties {
  @doc("Description of Solution template")
  description: string;

  @doc("List of capabilities")
  capabilities: string[];

  @doc("Latest solution template version")
  latestVersion: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Template Resource")
model SolutionTemplate is TrackedResource<SolutionTemplateProperties> {
  ...ResourceNameParameter<SolutionTemplate>;
}

@armResourceOperations
interface SolutionTemplates {
  @doc("Get a Solution Template Resource")
  get is ArmResourceRead<SolutionTemplate>;

  @doc("Create or update a Solution Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionTemplate>;

  @doc("update a Solution Template Resource")
  update is ArmResourcePatchSync<SolutionTemplate, SolutionTemplateProperties>;

  @doc("Delete a Solution Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<SolutionTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<SolutionTemplate>;
}
