import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./crossCatalog.tsp";
import "./_catalog.tsp";
import "./_tool.tsp";
import "./_model.tsp";
import "./_agent.tsp";
import "./_kb.tsp";

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
@service(#{ title: "Microsoft.Science.Catalog service" })
@versioned(Microsoft.Science.Catalog.Versions)
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
namespace Microsoft.Science.Catalog;

@doc("The Microsoft.Science.Catalog service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-11-01-preview version of the Microsoft.Science.Catalog service.")
  `2024-11-01-preview`,

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-07-01-preview version of the Microsoft.Science.Catalog service.")
  `2025-07-01-preview`,
}
