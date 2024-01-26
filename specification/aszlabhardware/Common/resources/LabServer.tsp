import "../models/LabResourceTypes.tsp";
import "../models/ResourceManager.tsp";
import "../models/System.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Common.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A physical computer which can be reserved for use by a user")
model LabServer is TrackedResource<LabServerProperties> {
    @doc("The name of the server")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("serverName")
    @segment("labservers")
    @path
    name: string;
}

@doc("Details of the AszLabHw LabServer.")
model LabServerProperties {
    @visibility("read")
    @doc("The current status of the GoalState")
    resourceManager?: ResourceManager;

    @visibility("read")
    @doc("The status of the LabServer")
    status?: string;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @visibility("read", "create")
    @doc("The OneAsset ID of the LabServer.")
    assetTag: string;

    @visibility("read", "create")
    @doc("IP address of the LabServer's BMC.")
    bmcIpAddress: string;

    @visibility("read")
    @doc("LabServer Inventory Information")
    inventory?: System;

    @visibility("create", "update", "read")
    @doc("LabServer banner. Temporary field during development.")
    banner?: string;

    @visibility("create", "update", "read")
    @doc("LabServer nickname. Temporary field during development.")
    nickname?: string;

    @visibility("read")
    @doc("Physical location of the LabServer.")
    physicalLocation?: string;
    
    @visibility("create", "update", "read")
    @doc("LabServer availability for reservation.")
    availableForReservationState?: LabResourceAvailableForReservationState;

    @visibility("read")
    @doc("LabServer reservation status.")
    reservationStatus?: LabResourceReservationStatus;

    @visibility("create", "update", "read")
    @doc("LabServer maintenance request state.")
    maintenanceRequestState?: LabResourceMaintenanceRequestState;

    @visibility("read")
    @doc("LabServer maintenance status.")
    maintenanceStatus?: LabResourceMaintenanceStatus;
}

@armResourceOperations
interface LabServers {
  get is ArmResourceRead<LabServer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<LabServer>;
  update is ArmResourcePatchSync<LabServer, LabServerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<LabServer>;
  listByResourceGroup is ArmResourceListByParent<LabServer>;
  listBySubscription is ArmListBySubscription<LabServer>;
  @doc("Collects the inventory of the server")
  collectInventory is ArmResourceActionNoContentSync<LabServer, {}>;
}