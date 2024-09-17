import "../../common/models/giVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface GiVersions extends OracleLocationBasedResource<GiVersion> {}
