import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./project.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AiForScience")
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Agent tracked resource")
model Agent is TrackedResource<AgentProperties> {
  ...ResourceNameParameter<Agent>;
}

@doc("Agent properties")
model AgentProperties {
  @doc("The description of the AI agent.")
  @visibility("read", "create", "update")
  description: string;

  @doc("The ID of the catalog agent.")
  @visibility("read", "create", "update")
  // TODO: Include "definition" in property name?
  catalogAgentId: string;

  @doc("The provisioning state of the AI agent.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Agents {
  get is ArmResourceRead<Agent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Agent>;
  update is ArmResourcePatchSync<
    Agent,
    {
      description: string;
    }
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Agent>;
  listByResourceGroup is ArmResourceListByParent<Agent>;
  listBySubscription is ArmListBySubscription<Agent>;
}
