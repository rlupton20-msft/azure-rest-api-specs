import "@azure-tools/typespec-azure-resource-manager";
import "../../common/models/ProxyOracleSubscription.tsp";
import "../../common/models/oracleCloudAccountDetails.tsp";
 
 
using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
 
 
namespace Private.OracleDatabaseDev;
 
@armResourceOperations
interface ProxyOracleSubscriptionOperations extends OracleSubscriptionLevelResource<ProxyOracleSubscription, ProxyOracleSubscriptionProperties> {
 
@doc("get cloud account info API")
@example(
    "./examples/OracleCloudAccount_get.json", 
    "Get oracle subscription details of azure subscription"
)
getCloudAccountInfo is ListActions.ArmResourceGetActionAsync<
    ProxyOracleSubscription,
    OracleCloudAccountDetails
>;
}
