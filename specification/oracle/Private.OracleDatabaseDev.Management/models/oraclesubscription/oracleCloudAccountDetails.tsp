using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Private.OracleDatabaseDev;

@doc("CloudAccount resource definition")
@parentResource(SubscriptionLocationResource)
model OracleCloudAccountDetails is ProxyResource<OracleCloudAccountProperties> {
  @doc("CloudAccountName")
  @key("cloudAccountName")
  @path
  @segment("cloudAccountName")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("CloudAccount resource model")
model OracleCloudAccountProperties {
  @doc("A valid Oracle Grid Infrastructure (GI) software version.")
  @visibility(Lifecycle.Read)
  @minLength(1)
  @maxLength(255)
  cloudAccountName: string;

  @doc("A valid Oracle Grid Infrastructure (GI) software version.")
  @visibility(Lifecycle.Read)
  cloudAccountHomeRegion: string;
}
