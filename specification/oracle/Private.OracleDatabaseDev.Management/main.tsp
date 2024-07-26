import "@azure-tools/typespec-autorest";
import "./operations/main.tsp";
import "./versions.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;
using Autorest;

@armProviderNamespace
@service({
  title: "Oracle Database Resource Manager",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@versioned(OracleDatabaseDev.Versions)
namespace Private.OracleDatabaseDev;

interface Operations extends Azure.ResourceManager.Operations {}

@@Autorest.example(Operations.list,
  "./examples/operations_list.json",
  "List Operations"
);
