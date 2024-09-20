import "../../common/models/systemVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface SystemVersions extends OracleLocationBasedResource<SystemVersion> {}
