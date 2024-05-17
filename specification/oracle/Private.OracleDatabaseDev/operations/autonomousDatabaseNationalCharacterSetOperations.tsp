import "../../common/models/autonomousDatabaseNationalCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface AutonomousDatabaseNationalCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseNationalCharacterSet> {}

@@example(AutonomousDatabaseNationalCharacterSets.listByLocation,
  "./examples/autonomousDatabaseNationalCharacterSet_listByLocation.json",
  "List autonomous db national character sets by location"
);
@@example(AutonomousDatabaseNationalCharacterSets.get,
  "./examples/autonomousDatabaseNationalCharacterSet_get.json",
  "Get autonomous db national character set"
);
