import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.MigrateWorkload;

@doc("The properties of a workload site")
model WorkLoadSiteProperties {
  @visibility("read")
  @doc("The provisioning state of the workload site")
  provisioningState?: ProvisioningState;
}
