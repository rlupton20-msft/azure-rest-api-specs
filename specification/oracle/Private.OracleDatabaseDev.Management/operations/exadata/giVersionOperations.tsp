import "../../models/exadata/giVersions.tsp";
import "../../models/exadata/giMinorVersions.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface GiVersions {
  #suppress "Deprecated" "Backward compatibility"
  @removed(Versions.v20241201_preview)
  @sharedRoute
  @renamedFrom(Versions.v20241201_preview, "listByLocation")
  listByLocationDeprecated is ArmResourceListByParent<GiVersion>;

  @added(Versions.v20241201_preview)
  @sharedRoute
  listByLocation is ArmResourceListByParent<
    GiVersion,
    Parameters = GiVersionFilter
  >;
}
