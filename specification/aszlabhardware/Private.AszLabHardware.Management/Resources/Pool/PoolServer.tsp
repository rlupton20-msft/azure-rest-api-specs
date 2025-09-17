using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

@doc("Private.AszLabHardware/Pool/Server resource")
@parentResource(Pool)
model PoolServer is ProxyResource<PoolServerProperties> {
  @doc("The name of the server")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("serverName")
  @segment("servers")
  @path
  name: string;
}

@doc("Private.AszLabHardware/Pool/Server properties")
model PoolServerProperties {
  ...ServerPropertiesBase;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Endpoint for managing the server")
  managementEndpoint?: string;
}

@armResourceOperations
interface PoolServers {
  get is ArmResourceRead<PoolServer>;
  listByParent is ArmResourceListByParent<PoolServer>;
}

scalar PoolServerResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.AszLabHardware/pools/servers",
    }
  ]>;
