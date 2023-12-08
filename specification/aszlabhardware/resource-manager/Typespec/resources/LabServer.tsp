import "../main.tsp";
import "../models/ResourceManager.tsp";
import "../models/System.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

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

    @visibility("read", "query")
    @doc("The status of the server")
    status?: string;

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
    inventory?: System;

    @visibility("create", "update", "read")
    @doc("Server banner. Temporary field during development.")
    banner?: string;

    @visibility("create", "update", "read")
    @doc("Server nickname. Temporary field during development.")
    nickname?: string;

    @visibility("read", "query")
    @doc("Physical location of the server.")
    physicalLocation?: string;
}

@armResourceOperations(LabServer)
interface LabServers extends TrackedResourceOperations<LabServer, LabServerProperties>{}
