import "./versions.tsp";
import "./publishConfigValues.tsp";
import "./sharedConfigValues.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure CIS FRP",
})
@doc("CloudSprout Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
@removed(Versions.v2024_08_31_preview)
union PublishConfigValuesProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

@doc("Provisioning status of the resource.")
@added(Versions.v2024_08_31_preview)
union SharedConfigValuesProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

