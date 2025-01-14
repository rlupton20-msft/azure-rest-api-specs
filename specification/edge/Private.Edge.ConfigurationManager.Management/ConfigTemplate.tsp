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

@doc("Config Template Properties")
model ConfigTemplateProperties {
  @doc("Description of config template")
  description: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Config Template Resource")
model ConfigTemplate is TrackedResource<ConfigTemplateProperties> {
  ...ResourceNameParameter<ConfigTemplate>;
  ...EntityTagProperty;
}

@armResourceOperations
interface ConfigTemplates {
  @doc("Get a Config Template Resource")
  get is ArmResourceRead<ConfigTemplate>;

  @doc("Create or update a Config Template Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConfigTemplate>;

  @doc("update a Config Template Resource")
  update is ArmResourcePatchSync<ConfigTemplate, ConfigTemplateProperties>;

  @doc("Delete a Config Template Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigTemplate>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<ConfigTemplate>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<ConfigTemplate>;
}
