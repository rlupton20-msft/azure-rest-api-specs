import "../../common/models/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {}
