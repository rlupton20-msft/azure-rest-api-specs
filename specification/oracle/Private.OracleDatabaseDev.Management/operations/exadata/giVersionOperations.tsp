import "../../models/exadata/giVersions.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface GiVersions {
  listByLocation is ArmResourceListByParent<
    GiVersion,
    Parameters = GiVersionFilter
  >;
  get is ArmResourceRead<GiVersion>;
}

@added(Versions.v20241201_preview)
@armResourceOperations
interface GiMinorVersions {
  listByParent is ArmResourceListByParent<
    GiMinorVersion,
    Parameters = GiMinorVersionFilter
  >;
  get is ArmResourceRead<GiMinorVersion>;
}
