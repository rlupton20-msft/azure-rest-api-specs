import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./UpdateType.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.Edge;

@doc("Available Orchestrator types")
union OrchestratorType {
  @doc("Toolchain Orchestrator type")
  TO: "TO",

  string,
}

@doc("Solution Template Version Properties")
model SolutionTemplateVersionProperties {
  @doc("Config expressions for this solution version")
  configurations: string;

  @doc("App components spec")
  spec: string;

  @doc("Orchestrator type")
  orchestratorType: OrchestratorType;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Template Version Resource")
@parentResource(SolutionTemplate)
@resource("versions")
model SolutionTemplateVersion
  is Azure.ResourceManager.ProxyResource<SolutionTemplateVersionProperties> {
  ...ResourceNameParameter<
    SolutionTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
}

@armResourceOperations
interface SolutionTemplateVersions {
  @doc("Get a Solution Template Version Resource")
  get is ArmResourceRead<SolutionTemplateVersion>;

  @doc("Create or update a Solution Template Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SolutionTemplateVersion,
    {
      ...BaseParameters<SolutionTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("update a Solution Template Version Resource")
  update is ArmResourcePatchSync<
    SolutionTemplateVersion,
    SolutionTemplateVersionProperties,
    {
      ...BaseParameters<SolutionTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("Delete a Solution Template Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<SolutionTemplateVersion>;

  @doc("List Solution Template Version Resources")
  listBySolutionTemplate is ArmResourceListByParent<SolutionTemplateVersion>;
}
