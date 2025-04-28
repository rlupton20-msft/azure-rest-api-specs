import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.Catalog.Versions)
namespace Microsoft.Discovery.Catalog;

@doc("A Catalog.")
@resource("catalogs")
model Catalog {
  @doc("The catalog name.")
  @visibility(Lifecycle.Read)
  @key("catalogName")
  @pattern(Microsoft.Discovery.Shared.resourceNamePattern)
  name: string;

  ...CatalogControlPlaneProxyResource;
}

@doc("A Catalog.")
interface Catalogs {
  @doc("Fetch a Catalog by name.")
  getCatalog is ResourceRead<Catalog>;

  @doc("List Catalog resources.")
  listModelDefinitions is ResourceList<Catalog>;
}
