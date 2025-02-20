import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_agent.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("A agent version.")
@parentResource(AgentDefinition)
@resource("versions")
model AgentDefinitionVersion {
  @doc("The agent version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseAgentDefinition;
}

@doc("A agent version.")
@parentResource(AgentDefinition)
@resource("versions")
model AgentDefinitionVersionWithYaml {
  @doc("The agent version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseAgentDefinition;
  ...WithDefinitionContents;
}

interface AgentDefinitionVersions {
  @doc("Fetch AgentDefinitionVersion by name.")
  getAgentDefinitionVersion is ResourceRead<AgentDefinitionVersion>;

  //  @doc("Creates a AgentDefinition.")
  //  createOrReplaceAgentDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<AgentDefinitionVersionWithYaml>;

  @doc("Updates AgentDefinition.")
  createOrUpdateAgentDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<AgentDefinitionVersionWithYaml>;

  @doc("List AgentDefinition resources")
  listAgentDefinitionVersions is ResourceList<AgentDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    AgentDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
