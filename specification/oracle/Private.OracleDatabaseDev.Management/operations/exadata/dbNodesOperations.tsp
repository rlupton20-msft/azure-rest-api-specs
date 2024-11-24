import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exadata/dbNodes.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbNodes extends OracleReadOnlyResource<DbNode> {
  // TODO: Swagger generator bug, cannot be extracted to interface
  listByParent is ArmResourceListByParent<DbNode>;

  @doc("VM actions on DbNode of VM Cluster by the provided filter")
  action is ArmResourceActionAsync<DbNode, DbNodeAction, DbNode>;
}
