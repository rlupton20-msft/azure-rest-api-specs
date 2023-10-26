import "../main.tsp";
import "./Inventory.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A physical computer which can be reserved for use by a user")
model Server is TrackedResource<ServerProperties> {
    @doc("The name of the server")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("serverName")
    @segment("servers")
    @path
    name: string;
}

@doc("Details of the AszLabHw Server.")
model ServerProperties {
    @visibility("read", "query")
    @doc("The status of the server")
    status: string;

    @visibility("read")
    @doc("The current status of the GoalState")
    goalStateStatus: string;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @visibility("read", "create")
    @doc("The OneAsset ID of the server.")
    assetTag: string;

    @visibility("read", "create")
    @doc("IP address of the server's BMC.")
    bmcIpAddress: string;

    @visibility("read", "query")
    @doc("Server Inventory Information")
    inventory?: Inventory;
}

@armResourceOperations(Server)
interface Servers extends TrackedResourceOperations<Server, ServerProperties>{}
