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

@doc("SolutionSchema Properties")
model SolutionSchemaProperties {
  @doc("Value of schema")
  value: string;

  @doc("Heirarchy Level")
  level: string;

  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("SolutionSchema Resource")
@parentResource(SolutionTemplateVersion)
model SolutionSchema is ProxyResource<SolutionSchemaProperties> {
  @doc("The name of the SolutionSchemaProperties")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("solutionSchemaName")
  @segment("solutionSchema")
  name: string;

  ...EntityTagProperty;
}

@armResourceOperations
interface SolutionSchemas {
  @doc("Get a SolutionSchema Resource")
  get is ArmResourceRead<SolutionSchema>;

  @doc("List by SolutionTemplateVersion")
  listBySolutionTemplateVersion is ArmResourceListByParent<SolutionSchema>;
}
