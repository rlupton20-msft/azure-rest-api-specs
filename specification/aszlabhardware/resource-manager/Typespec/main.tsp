import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../../Common/resources/LabServer.tsp";
import "../../Common/resources/Reservation.tsp";
import "../../Common/resources/Server.tsp";

import "../../Common/common.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Private.AszLabHardware")
@service({
  title: "Private.AszLabHardware",
})
@versioned(Versions)

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Private.AszLabHardware;
