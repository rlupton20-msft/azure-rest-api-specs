import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_agent.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A agent version.")
@parentResource(Agent)
@resource("versions")
model AgentVersion {
  @doc("The agent version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseAgent;
}

interface AgentVersions {
  @doc("Fetch AgentVersion by name.")
  getAgentVersion is ResourceRead<AgentVersion>;

  @doc("Creates a Agent.")
  createOrReplaceAgentVersion is StandardResourceOperations.ResourceCreateOrReplace<AgentVersion>;

  @doc("Updates Agent.")
  createOrUpdateAgentVersion is StandardResourceOperations.ResourceCreateOrUpdate<AgentVersion>;

  @doc("List Agent resources")
  listAgentVersions is ResourceList<AgentVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    AgentVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
