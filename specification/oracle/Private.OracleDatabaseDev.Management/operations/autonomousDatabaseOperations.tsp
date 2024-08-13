import "../../common/models/autonomousDatabase.tsp";
import "./commons.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
namespace Private.OracleDatabaseDev;

@armResourceOperations(AutonomousDatabase)
interface AutonomousDatabases
  extends OracleTrackedResource<
      AutonomousDatabase,
      AutonomousDatabaseBaseProperties
    > {
  //OCI switchover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/SwitchoverAutonomousDatabase
  @doc("Perform switchover action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_switchover.json",
    "Perform switchover action on Autonomous Database"
  )
  switchover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI failover API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/FailOverAutonomousDatabase
  @doc("Perform failover action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_failover.json",
    "Perform failover action on Autonomous Database"
  )
  failover is ArmResourceActionAsync<
    AutonomousDatabase,
    PeerDbDetails,
    AutonomousDatabase
  >;

  //OCI generate wallet API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/GenerateAutonomousDatabaseWallet
  @doc("Generate wallet action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_generateWallet.json",
    "Generate wallet action on Autonomous Database"
  )
  generateWallet is ArmResourceActionSync<
    AutonomousDatabase,
    GenerateAutonomousDatabaseWalletDetails,
    AutonomousDatabaseWalletFile
  >;

  //OCI RestoreAutonomousDatabase API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/RestoreAutonomousDatabase
  @doc("Restores an Autonomous Database based on the provided request parameters.")
  @Autorest.example(
    "./examples/autonomousDatabaseBackup_restore.json",
    "Perform restore action on Autonomous Database"
  )
  restore is ArmResourceActionAsync<
    AutonomousDatabase,
    RestoreAutonomousDatabaseDetails,
    AutonomousDatabase
  >;

  //OCI ChangeDisasterRecoveryConfiguration API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/ChangeDisasterRecoveryConfiguration
  @added(Versions.v20241001_preview)
  @doc("Perform ChangeDisasterRecoveryConfiguration action on Autonomous Database")
  @Autorest.example(
    "./examples/autonomousDatabase_changeDisasterRecoveryConfiguration.json",
    "Perform ChangeDisasterRecoveryConfiguration action on Autonomous Database"
  )
  changeDisasterRecoveryConfiguration is ArmResourceActionAsync<
    AutonomousDatabase,
    DisasterRecoveryConfigurationDetails,
    AutonomousDatabase
  >;
}

//OCI ListAutonomousDatabasePeers API doc: https://docs.oracle.com/en-us/iaas/api/#/en/database/20160918/AutonomousDatabase/ListAutonomousDatabasePeers
@added(Versions.v20241001_preview)
@armResourceOperations(AutonomousDatabase)
interface AutonomousDatabasePeers {
  @Autorest.example(
    "./examples/autonomousDatabasePeers_listByParent.json",
    "List Autonomous Database Peers by Autonomous Database."
  )
  listByParent is ArmResourceListByParent<AutonomousDatabasePeer>;
}

@@Autorest.example(AutonomousDatabases.listBySubscription,
  "./examples/autonomousDatabase_listBySubscription.json",
  "List Autonomous Database by subscription"
);
@@Autorest.example(AutonomousDatabases.listByResourceGroup,
  "./examples/autonomousDatabase_listByResourceGroup.json",
  "List Autonomous Database by resource group"
);
@@Autorest.example(AutonomousDatabases.createOrUpdate,
  "./examples/autonomousDatabase_create.json",
  "Create Autonomous Database"
);
@@Autorest.example(AutonomousDatabases.createOrUpdate,
  "./examples/autonomousDatabaseClone_create.json",
  "Create clone Autonomous Database"
);
@@Autorest.example(AutonomousDatabases.get,
  "./examples/autonomousDatabase_get.json",
  "Get Autonomous Database"
);
@@Autorest.example(AutonomousDatabases.update,
  "./examples/autonomousDatabase_patch.json",
  "Patch Autonomous Database"
);
@@Autorest.example(AutonomousDatabases.delete,
  "./examples/autonomousDatabase_delete.json",
  "Delete Autonomous Database"
);
