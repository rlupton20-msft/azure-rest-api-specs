import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./root.tsp";
import "./_catalog.tsp";
import "./_tool.tsp";
//import "./_tool_version.tsp";
import "./_model.tsp";
//import "./_model_version.tsp";
import "./_agent.tsp";
//import "./_agent_version.tsp";
//import "./_dataAsset.tsp";
//import "./_dataAsset_version.tsp";
import "./_kb.tsp";
//import "./_kb_version.tsp";

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

      scopes: ["https://catalog.science.microsoft.com/.default"],
    }
  ]>
)
@service({
  title: "Microsoft.AiForScience.Catalog service",
})
@versioned(Microsoft.AiForScience.Catalog.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/catalogs/{catalogName}",
  "Science Catalog API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported Microsoft Science Catalog Services endpoints (protocol and hostname, for example: https://{workspaceName}.science.azure.com).
      """)
    endpoint: url,

    @doc("Catalog name")
    catalogName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.AiForScience.Catalog;

@doc("The Microsoft.AiForScience.Catalog service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-01-preview version of the Microsoft.AiForScience.Catalog service.")
  `2024-11-01-preview`,
}
