import "@azure-tools/typespec-azure-resource-manager";
import "../../common/models/autonomousDatabaseVersion.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface AutonomousDatabaseVersions
  extends OracleLocationBasedResource<AutonomousDbVersion> {}

@@Autorest.example(AutonomousDatabaseVersions.listByLocation,
  "./examples/autonomousDatabaseVersion_listByLocation.json",
  "List an autonomous versions by location"
);
@@Autorest.example(AutonomousDatabaseVersions.get,
  "./examples/autonomousDatabaseVersion_get.json",
  "Get an autonomous version"
);
