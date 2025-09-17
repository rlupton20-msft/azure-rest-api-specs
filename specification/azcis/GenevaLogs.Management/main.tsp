import "./versions.tsp";
import "./genevalogsaccounts.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("Geneva Logs Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

@OpenAPI.extension(
  "x-ms-examples",
  #{
    Operations: "./examples/2023-08-22-preview/GenevaLogsAccounts_Operations.json",
  }
)
interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union GenevaLogsProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
