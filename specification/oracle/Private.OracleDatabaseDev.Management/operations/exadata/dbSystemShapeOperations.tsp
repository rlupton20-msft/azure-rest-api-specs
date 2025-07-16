import "../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {
  @added(Versions.v20250801_preview)
  listByLocation is ArmResourceListByParent<
    DbSystemShape,
    Parameters = DbSystemShapeFilter
  >;
}
