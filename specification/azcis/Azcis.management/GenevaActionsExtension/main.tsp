import "../versions.tsp";
import "./genevaactionsextension.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Azure CIS - Geneva Actions Extension",
})
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/geneva/geneva-actions-extension-resource-template")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union GenevaActionsExtensionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
