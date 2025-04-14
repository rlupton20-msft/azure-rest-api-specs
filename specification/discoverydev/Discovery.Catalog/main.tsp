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
// import "../Discovery.Shared/shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.discovery.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://catalog.discovery.microsoft.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft.Discovery.Catalog service" })
@versioned(Microsoft.Discovery.Catalog.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/catalogs/{catalogName}",
  "Discovery Catalog API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported Azure Discovery Catalog Services endpoints (protocol and hostname, for example: https://{workspaceName}.discovery.azure.com).
      """)
    endpoint: url,

    @doc("Catalog name")
    catalogName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.Discovery.Catalog;

@doc("The Microsoft.Discovery.Catalog service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Microsoft.Discovery.Shared.Versions.`2025-07-01-preview`)
  @doc("The 2025-07-01-preview version of the Microsoft.Discovery.Catalog service data plane.")
  `2025-07-01-preview`,
}
