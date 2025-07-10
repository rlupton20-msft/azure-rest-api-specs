import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./_knowledgeBase.tsp";
import "./_knowledgeBase_version.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.discovery.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://bookshelf.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft.Bookshelf service" })
@versioned(Microsoft.Discovery.Bookshelf.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/Bookshelves/{bookshelfName}",
  "Discovery Bookshelf API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported Microsoft Bookshelf Services endpoints (protocol and hostname, for example: https://{bookshelfName}.discovery.azure.com).
      """)
    endpoint: url,

    @doc("Bookshelf name")
    bookshelfName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.Discovery.Bookshelf;

@doc("The Microsoft.Discovery.Bookshelf service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Microsoft.Discovery.Shared.Versions.`2025-07-01-preview`)
  @doc("The 2025-07-01-preview version of the Microsoft.Discovery.Bookshelf service data plane.")
  `2025-07-01-preview`,
}
