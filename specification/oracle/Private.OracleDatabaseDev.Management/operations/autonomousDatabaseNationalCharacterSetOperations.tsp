import "../../common/models/autonomousDatabaseNationalCharacterSet.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface AutonomousDatabaseNationalCharacterSets
  extends OracleLocationBasedResource<AutonomousDatabaseNationalCharacterSet> {}
