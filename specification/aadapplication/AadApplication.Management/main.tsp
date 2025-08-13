import "./versions.tsp";
import "./aadapplication.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/aad-application")
@versioned(Microsoft.AadApplication.Versions)
namespace Microsoft.AadApplication;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union AadApplicationProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
