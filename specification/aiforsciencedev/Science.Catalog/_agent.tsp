import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_catalog.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("AgentDefinition attributes from definitionContents")
model AgentDefinitionAttributes {
  ...BaseAttributesWithDescription;
}

@doc("A base agent.")
model BaseAgentDefinition {
  ...Artifact<AgentDefinitionAttributes>;
}

@doc("An agent.")
@parentResource(Catalog)
@resource("agentDefinitions")
model AgentDefinition {
  @doc("The agent name.")
  @visibility("read")
  @key("agentName")
  name: string;

  ...BaseAgentDefinition;
}

@doc("An agent.")
@parentResource(Catalog)
@resource("agentDefinitions")
model AgentDefinitionWithYaml {
  @doc("The agent name.")
  @visibility("read")
  @key("agentName")
  name: string;

  ...BaseAgentDefinition;
  ...WithDefinitionContents;
}

interface AgentDefinitions {
  @doc("Fetch AgentDefinition by name.")
  getAgentDefinition is ResourceRead<AgentDefinition>;

  @doc("Creates an AgentDefinition.")
  createOrReplaceAgentDefinition is StandardResourceOperations.ResourceCreateOrReplace<AgentDefinitionWithYaml>;

  @doc("Updates an AgentDefinition.")
  createOrUpdateAgentDefinition is StandardResourceOperations.ResourceCreateOrUpdate<AgentDefinitionWithYaml>;

  @doc("List AgentDefinition resources")
  listAgentDefinitions is ResourceList<AgentDefinition>;

  @doc("Delete an AgentDefinition.")
  deleteAgentDefinition is ResourceDelete<AgentDefinition>;
}
