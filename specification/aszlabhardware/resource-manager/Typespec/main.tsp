import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

import "../../Common/resources/LabServer.tsp";
import "../../Common/resources/Reservation.tsp";
import "../../Common/resources/Server.tsp";

import "../../Common/common.tsp";

using Azure.ResourceManager;

@armProviderNamespace("Private.AszLabHardware")
@service({
    title: "Private.AszLabHardware",
    version: "2023-10-01-preview",
})

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Common.AszLabHardware;
