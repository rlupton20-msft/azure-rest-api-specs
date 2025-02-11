import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_catalog.tsp";
import "./_agent_version.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("Agent attributes from definitionContents")
model AgentAttributes {
  ...BaseAttributesWithDescription;
}

@doc("A base agent.")
model BaseAgent {
  ...Artifact<AgentAttributes>;
}

@doc("An agent.")
@parentResource(Catalog)
@resource("agents")
model Agent {
  @doc("The agent name.")
  @visibility("read")
  @key("agentName")
  name: string;

  ...BaseAgent;
}

interface Agents {
  @doc("Fetch Agent by name.")
  getAgent is ResourceRead<Agent>;

  @doc("Creates an Agent.")
  createOrReplaceAgent is StandardResourceOperations.ResourceCreateOrReplace<Agent &
    WithDefinitionContents>;

  @doc("Updates an Agent.")
  createOrUpdateAgent is StandardResourceOperations.ResourceCreateOrUpdate<Agent &
    WithDefinitionContents>;

  @doc("List Agent resources")
  listAgents is ResourceList<Agent>;

  @doc("Delete an Agent.")
  deleteAgent is ResourceDelete<Agent>;

  //  @doc("Create an AgentVersion from current state.")
  //  createVersion is Operations.ResourceAction<Agent, {}, AgentVersion>;
  //
  //  @doc("Get an up to date draft AgentVersion. If newest version is different than current Agent, create a new version. Returns (potentially newly created) latest version.")
  //  draftVersion is Operations.ResourceAction<Agent, {}, AgentVersion>;
}
