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

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A Catalog.")
@resource("catalogs")
model Catalog {
  @doc("The catalog name.")
  @visibility(Lifecycle.Read)
  @key("catalogName")
  name: string;
}

@doc("A Catalog.")
interface CatalogInt {}
