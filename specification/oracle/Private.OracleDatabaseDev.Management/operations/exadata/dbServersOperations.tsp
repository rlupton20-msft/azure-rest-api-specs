import "@azure-tools/typespec-azure-resource-manager";
import "../commons.tsp";
import "../../models/exadata/dbServers.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbServers extends OracleReadOnlyResource<DbServer> {
  listByParent is ArmResourceListByParent<DbServer>;
}
