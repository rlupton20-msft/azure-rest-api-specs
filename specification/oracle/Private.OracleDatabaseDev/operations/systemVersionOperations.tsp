import "../../common/models/systemVersions.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface SystemVersions extends OracleLocationBasedResource<SystemVersion> {}

@@example(SystemVersions.listByLocation,
  "./examples/systemVersions_listSystemVersions.json",
  "List Exadata System Versions by the provided filter"
);
