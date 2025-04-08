import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_project.tsp";
import "./_investigation.tsp";
import "./_conversation.tsp";
import "./_conversation_message.tsp";
// import "./_conversation_message_confirmation.tsp";
// import "./_conversation_message_dataAssets.tsp";
// import "./_conversation_message_logs.tsp";
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
@service(#{ title: "Microsoft.Science.Workspace service" })
@versioned(Microsoft.Science.Workspace.Versions)
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
namespace Microsoft.Science.Workspace;

@doc("The Microsoft.Science.Workspace service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-01-preview version of the Microsoft.Science.Workspace service data plane.")
  `2024-11-01-preview`,

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-07-01-preview version of the Microsoft.Science.Workspace service data plane.")
  `2025-07-01-preview`,
}
