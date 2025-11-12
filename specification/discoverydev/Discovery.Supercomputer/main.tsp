import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,

      // TODO: Work with backend team to determine authorizationUrl and scopes.
      authorizationUrl: "https://login.discovery.azure.com/common/oauth2/v2.0/authorize",

      scopes: ["https://supercomputer.discovery.azure.com/.default"],
    }
  ]>
)
@service(#{ title: "Microsoft.Discovery.Supercomputer service" })
@versioned(Microsoft.Discovery.Supercomputer.Versions)
@server(
  // TODO: Work with backend team to determine server endpoint.
  "{endpoint}/supercomputers/{supercomputerName}",
  "Discovery Supercomputer API",
  {
    // TODO: Work with backend team to determine example.
    @doc("""
      Supported Discovery Supercomputer Services endpoints (protocol and hostname, for example: https://{supercomputerName}.discovery.azure.com).
      """)
    endpoint: url,

    @doc("Supercomputer name")
    supercomputerName: string,

    @doc("API Version")
    @path
    apiVersion: Versions,
  }
)
namespace Microsoft.Discovery.Supercomputer;

@doc("The Microsoft.Discovery.Supercomputer service versions.")
enum Versions {
  @useDependency(Microsoft.Discovery.Shared.Versions.`2025-12-01-preview`)
  @doc("The 2025-12-01-preview version of the Microsoft.Discovery.Supercomputer service data plane.")
  `2025-12-01-preview`,
}
