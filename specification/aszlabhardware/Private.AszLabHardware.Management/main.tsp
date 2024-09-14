import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./apiversion.tsp";
import "./operations.tsp";
import "./resources/LabServer.tsp";
import "./resources/Server.tsp";
import "./resources/Reservation.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "AszLabHardware Resource Provider",
})
@versioned(AszLabHardwareCurrentVersion)
namespace Private.AszLabHardware;
