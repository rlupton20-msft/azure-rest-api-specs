import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_knowledgeBase.tsp";
import "./_knowledgeBase_version.tsp";
import "./_project.tsp";
import "./_investigation.tsp";
//import "./_investigation_version.tsp";
import "./_run.tsp";
import "./_run_step.tsp";
import "./_message.tsp";
import "./_conversation.tsp";
import "./_conversation_message.tsp";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.science.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://workspace.science.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft.AiForScience.Workspace service",
})
@versioned(Microsoft.AiForScience.Workspace.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/workspaces/{workspaceName}",
  "Science Workspace API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported Microsoft Science Workspace Services endpoints (protocol and hostname, for example: https://{workspaceName}.science.azure.com).
      """)
    endpoint: url,

    @doc("Workspace name")
    workspaceName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.AiForScience.Workspace;

@doc("The Microsoft.AiForScience.Workspace service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-12-01-preview version of the Microsoft.AiForScience.Workspace service.")
  `2024-12-01-preview`,
}
