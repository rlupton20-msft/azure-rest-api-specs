import "../../common/models/autonomousDatabaseBackup.tsp";
import "./commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations(AutonomousDatabaseBackup)
interface AutonomousDatabaseBackups
  extends OracleChildResource<
      AutonomousDatabaseBackup,
      AutonomousDatabaseBackupProperties
    > {
  update is ArmResourcePatchAsync<
    AutonomousDatabaseBackup,
    AutonomousDatabaseBackupProperties
  >;

  listByParent is ArmResourceListByParent<AutonomousDatabaseBackup>;
}
