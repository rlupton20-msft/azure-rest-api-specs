import "@azure-tools/typespec-azure-resource-manager";
import "../../common/models/oracleCloudAccountDetails.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface OracleCloudAccount
    extends OracleLocationBasedResource<OracleCloudAccountDetails> {}

@@Autorest.example(OracleCloudAccount.get,
    "./examples/OracleCloudAccount_get.json",
    "Get oracle subscription details of azure subscription"
);
