import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Static Configuration Properties")
model StaticConfigurationProperties {
  @doc("Schema Id for configuration")
  schemaId?: string;

  @doc("Values of configuration, should be in yaml format")
  values: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Static Configuration Resource")
@parentResource(Configuration)
model StaticConfiguration is ProxyResource<StaticConfigurationProperties> {
  ...ResourceNameParameter<StaticConfiguration>;
}

@armResourceOperations
interface StaticConfigurations {
  @doc("Get a Static Configuration Resource")
  get is ArmResourceRead<StaticConfiguration>;

  @doc("Create or update a Static Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StaticConfiguration>;

  @doc("Update a Static Configuration Resource")
  update is ArmResourcePatchSync<
    StaticConfiguration,
    StaticConfigurationProperties
  >;

  @doc("Delete a Static Configuration Resource")
  delete is ArmResourceDeleteSync<StaticConfiguration>;

  @doc("List Static Configuration Resources")
  listByConfiguration is ArmResourceListByParent<StaticConfiguration>;
}
