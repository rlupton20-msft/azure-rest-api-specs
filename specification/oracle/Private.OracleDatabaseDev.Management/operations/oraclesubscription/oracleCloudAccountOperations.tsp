import "@azure-tools/typespec-azure-resource-manager";
import "../../models/oraclesubscription/oracleCloudAccountDetails.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface OracleCloudAccount
  extends OracleLocationBasedResource<OracleCloudAccountDetails> {}
