import "../versions.tsp";
import "./genevaactionsextension.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
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
