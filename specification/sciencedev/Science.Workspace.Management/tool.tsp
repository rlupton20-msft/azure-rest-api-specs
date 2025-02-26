import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./project.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Tool tracked resource")
model Tool is TrackedResource<ToolProperties> {
  ...ResourceNameParameter<Tool>;
}

@doc("Science Tool properties")
model ToolProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Tool description used for copilot prompt and execution.")
  @visibility("read", "create", "update")
  description: string;

  @doc("Reference to catalog tool definition.")
  @visibility("read", "create", "update")
  // TODO: Include "definition" in property name?
  catalogToolId: string;

  @doc("The parameters of the execution.")
  @visibility("read", "create", "update")
  parameters?: Parameter[];

  @doc("The ID of the workspace.")
  @visibility("read", "create")
  workspaceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/workspace";
    }
  ]>;
}

@doc("Parameter model for executions")
model Parameter {
  @doc("The name of the parameter.")
  name: string;

  @doc("The value of the parameter.")
  value: string;
}

@armResourceOperations
interface Tools {
  get is ArmResourceRead<Tool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Tool>;
  update is ArmResourcePatchSync<Tool, ToolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Tool>;
  listByResourceGroup is ArmResourceListByParent<Tool>;
  listBySubscription is ArmListBySubscription<Tool>;
}
