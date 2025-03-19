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

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("AgentDefinition attributes from definitionContents")
model AgentDefinitionAttributes {
  ...BaseAttributesWithDescription;
}

@doc("A catalog agent definition.")
@parentResource(Catalog)
@resource("agentDefinitions")
model AgentDefinition {
  @doc("The agent name.")
  @visibility(Lifecycle.Read)
  @key("agentName")
  name: string;

  ...Artifact<AgentDefinitionAttributes>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("An agent.")
@parentResource(Catalog)
@resource("agentDefinitions")
model AgentDefinitionWithYaml extends AgentDefinition {
  ...WithDefinitionContents;
}

interface AgentDefinitions {
  @doc("Fetch AgentDefinition by name.")
  getAgentDefinition is ResourceRead<AgentDefinition>;

  @doc("Creates an AgentDefinition.")
  createOrReplaceAgentDefinition is StandardResourceOperations.ResourceCreateOrReplace<AgentDefinitionWithYaml>;

  @doc("Updates an AgentDefinition.")
  createOrUpdateAgentDefinition is StandardResourceOperations.ResourceCreateOrUpdate<AgentDefinitionWithYaml>;

  @doc("List AgentDefinition resources within Catalog.")
  listAgentDefinitions is ResourceList<AgentDefinition>;

  @doc("Delete an AgentDefinition.")
  deleteAgentDefinition is ResourceDelete<AgentDefinition>;
}
