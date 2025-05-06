import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Discovery")
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Agent tracked resource")
model Agent is TrackedResource<AgentProperties> {
  ...ResourceNameParameter<Agent>;
}

@doc("Tool reference")
model ToolReference {
  @doc("The resource ID of the tool.")
  toolId: string;

  @doc("The name of the tool.")
  name: string;
}

@doc("Agent reference")
model AgentReference {
  @doc("The resource ID of the agent.")
  agentId: string;

  @doc("The name of the agent.")
  name: string;
}

@doc("Knowledgebase reference")
model KnowledgeBaseReference {
  @doc("The resource ID of the knowledge base.")
  knowledgeBaseId: string;

  @doc("The name of the knowledge base.")
  name: string;
}

@doc("Agent properties")
model AgentProperties {
  @doc("Reference to agent definition.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  agentDefinitionId: string;

  @doc("Agent definition YAML as a string.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  definitionContent: string;

  @doc("Reference to the model.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  modelId: string;

  @doc("References to the tools.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  toolSet?: ToolReference[];

  @doc("References to the agents.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agentSet?: AgentReference[];

  @doc("References to the knowledgebases.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  knowledgeBaseSet?: KnowledgeBaseReference[];

  @doc("The provisioning state of the AI agent.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Agents {
  get is ArmResourceRead<Agent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Agent>;
  update is ArmResourcePatchAsync<Agent, AgentProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Agent>;
  listByResourceGroup is ArmResourceListByParent<Agent>;
  listBySubscription is ArmListBySubscription<Agent>;
}
