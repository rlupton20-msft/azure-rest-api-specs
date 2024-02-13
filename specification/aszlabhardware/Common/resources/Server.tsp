import "../models/ResourceManager.tsp";
import "../models/UserLabResourceTypes.tsp";
import "./Reservation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Common.AszLabHardware;

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
    @doc("The OneAsset ID of the Server.")
    assetTag: string;

    @visibility("read")
    @doc("IP address of the Server's BMC.")
    bmcIpAddress: string;

    @visibility("read")
    @doc("Server Inventory Information")
    inventory?: System;

    @visibility("read")
    @doc("Server maintenance status.")
    maintenanceStatus?: UserLabResourceMaintenanceStatus;

    @visibility("read", "update")
    @doc("User name of the account credential to authenticate to the server.")
    userName?: string;

    @visibility("read", "update")
    @doc("Keyvault Uri for the password of the account credential to authenticate to the server.")
    userPasswordKeyVaultUri?: string;
  }

@armResourceOperations
interface Servers {
  get is ArmResourceRead<Server>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Server>;
  update is ArmResourcePatchSync<Server, ServerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Server>;
  listByResourceGroup is ArmResourceListByParent<Server>;
  listBySubscription is ArmListBySubscription<Server>;
  @doc("Allows any requested maintenance on this Server")
  allowMaintenance is ArmResourceActionSync<Server, void, void>;
}
