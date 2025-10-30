import "./connection.tsp";

using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

// https://docs.oracle.com/en-us/iaas/api/#/en/goldengate/20200407/datatypes/CreateOracleConnectionDetails

@added(Versions.v20251001_preview)
@doc("Allowed modes for database connection session.")
union SessionMode {
  @doc("for a non-RAC database")
  Direct: "DIRECT",

  @doc("for a RAC database")
  Redirect: "REDIRECT",

  string,
}

@added(Versions.v20251001_preview)
@doc("Allowed values for Oracle technology type.")
union OracleConnectionTechnologyType {
  @doc("Oracle databases hosted on Amazon RDS.")
  AmazonRdsOracle: "AMAZON_RDS_ORACLE",

  @doc("OCI ADB.")
  OciAutonomousDatabase: "OCI_AUTONOMOUS_DATABASE",

  @doc("On-premise Oracle database.")
  OracleDatabase: "ORACLE_DATABASE",

  @doc("On-premise Exadb.")
  OracleExadata: "ORACLE_EXADATA",

  @doc("Exadb @Azure.")
  OracleExadataDatabaseAtAzure: "ORACLE_EXADATA_DATABASE_AT_AZURE",

  @doc("Exadb @GCP.")
  OracleExadataDatabaseAtGoogleCloud: "ORACLE_EXADATA_DATABASE_AT_GOOGLE_CLOUD",

  @doc("Exadb @AWS.")
  OracleExadataDatabaseAtAws: "ORACLE_EXADATA_DATABASE_AT_AWS",

  @doc("ADB @Azure.")
  OracleAutonomousDatabaseAtAzure: "ORACLE_AUTONOMOUS_DATABASE_AT_AZURE",

  @doc("ADB @GCP.")
  OracleAutonomousDatabaseAtGoogleCloud: "ORACLE_AUTONOMOUS_DATABASE_AT_GOOGLE_CLOUD",

  @doc("ADB @AWS.")
  OracleAutonomousDatabaseAtAws: "ORACLE_AUTONOMOUS_DATABASE_AT_AWS",

  string,
}

@added(Versions.v20251001_preview)
@doc("The metadata of an Oracle Database Connection.")
model OracleConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.Oracle;

  @doc("The Oracle technology type.")
  technologyType: OracleConnectionTechnologyType;

  @doc("The mode of the database connection session to be established by the data client.")
  sessionMode: SessionMode;

  @doc("The username that is used to connect the associated system of the given technology.")
  username: string;

  #deprecated "replaced by `passwordSecretId`"
  @doc("The password this is used to connect the associated system of the given technology.")
  @minLength(0)
  @maxLength(255)
  password?: Password;

  @doc("The OCID of the Secret where the password is stored.")
  passwordSecretId?: Ocid;

  @doc("The base64 encoded wallet files.")
  walletFiles?: string;
}
