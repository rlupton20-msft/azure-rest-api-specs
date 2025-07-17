import "../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {
  #suppress "Deprecated" "Backward compatibility"
  @removed(Versions.v20250801_preview)
  @sharedRoute
  @renamedFrom(Versions.v20250801_preview, "listByLocation")
  listByLocationDeprecated is ArmResourceListByParent<DbSystemShape>;

  @added(Versions.v20250801_preview)
  @sharedRoute
  listByLocation is ArmResourceListByParent<
    DbSystemShape,
    Parameters = DbSystemShapeFilter
  >;
}
