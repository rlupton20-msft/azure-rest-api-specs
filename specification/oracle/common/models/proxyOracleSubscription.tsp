using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Private.OracleDatabaseDev;;

@singleton
@subscriptionResource
@doc("OracleSubscription resource definition")
@friendlyName("ProxyOracleSubscription")
model ProxyOracleSubscription
  is ProxyResource<ProxyOracleSubscriptionProperties> {
  @doc("ProxyOracleSubscription name")
  @key("proxyoraclesubscriptionname")
  @path
  @segment("proxyoracleSubscriptions")
  @pattern(".*")
  name: string;
}

@doc("OracleSubscriptionProvisioningState enum")
union ProxyOracleSubscriptionProvisioningState {
  ResourceProvisioningState,
  string,
}

/** 
 * The properties of ProxyOracleSubscription
*/
@doc("The properties of ProxyOracleSubscription")
model ProxyOracleSubscriptionProperties {
 
  @doc("Parent SubscriptionId")
  @visibility("read", "update")
  parentSubscriptionId?: string;

  @doc("OracleSubscriptionProvisioningState provisioning state")
  @visibility("read")
  provisioningState?: ProxyOracleSubscriptionProvisioningState;
 
}