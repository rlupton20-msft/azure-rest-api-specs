import "../main.tsp";
import "../models/ResourceManager.tsp";
import "./Reservation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@parentResource(Reservation)
model Server is TrackedResource<ServerProperties> {
  @doc("server name")
  @segment("servers")
  @key("serverName")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @path
  name: string;
}

@doc("Details of the AszLabHw Server.")
model ServerProperties {
    @visibility("read")
    @doc("The current status of the GoalState")
    resourceManager?: ResourceManager;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @visibility("read")
    @doc("The OneAsset ID of the server.")
    assetTag: string;

    @visibility("read")
    @doc("IP address of the server's BMC.")
    bmcIpAddress: string;

    @visibility("read", "query")
    @doc("Server Inventory Information")
    inventory?: System;
}

@armResourceOperations(Server)
interface Servers extends TrackedResourceOperations<Server, ServerProperties>{}
