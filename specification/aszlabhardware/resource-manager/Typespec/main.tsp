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
namespace Private.AszLabHardware;

scalar ServerResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.AszLabHardware/servers",
    }
  ]>;
