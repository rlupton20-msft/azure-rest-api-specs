import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_project.tsp";
import "./_investigation.tsp";
import "./_investigation_version.tsp";
import "./_run.tsp";
import "./_message.tsp";
import "./_conversation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.aiforscience.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://workspace.aiforscience.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft.AiForScienceWorkspace service",
})
@versioned(Microsoft.AiForScienceWorkspace.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/workspaces/{workspaceName}",
  "Azure AI for Science Workspace API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported AI for Science Workspace Services endpoints (protocol and hostname, for example: https://{workspaceName}.aiforscience.azure.com).
      """)
    endpoint: url,

    @doc("Workspace name")
    workspaceName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.AiForScienceWorkspace;

@doc("The Microsoft.AiForScienceWorkspace service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-12-01-preview version of the Microsoft.AiForScienceWorkspace service.")
  `2024-12-01-preview`,
}
