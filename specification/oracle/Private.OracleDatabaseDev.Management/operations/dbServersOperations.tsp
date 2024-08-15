import "@azure-tools/typespec-azure-resource-manager";
import "../../common/operations/commons.tsp";
import "../../common/models/dbServers.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbServers extends OracleReadOnlyResource<DbServer> {
  @Autorest.example(
    "./examples/dbServers_listByParent.json",
    "List DbServers by Exadata Infrastructure"
  )
  listByParent is ArmResourceListByParent<DbServer>;
}

@@Autorest.example(DbServers.get,
  "./examples/dbServers_get.json",
  "Get DbServer by parent"
);
