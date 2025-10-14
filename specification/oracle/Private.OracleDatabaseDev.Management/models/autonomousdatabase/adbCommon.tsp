using OpenAPI;
using TypeSpec.Versioning;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

namespace Private.OracleDatabaseDev;

scalar AutonomousDatabaseId
  extends armResourceIdentifier<[
    {
      type: "Private.OracleDatabaseDev/autonomousDatabases",
    }
  ]>;

@doc("Retention period, in days, for backups.")
@minValue(60)
@maxValue(2558)
scalar RetentionPeriod extends int32;

@added(Versions.v20250815_preview)
@doc("Retention period, in days, for long-term backups")
@minValue(90)
@maxValue(3650)
scalar LongTermBackUpRetentionPeriod extends int32;
