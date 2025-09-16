import "./versions.tsp";
import "./genevalogsaccounts.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure CIS FRP",
})
@doc("Geneva Logs Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union GenevaLogsProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
