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
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-core/no-enum" "Azure services should not use the enum keyword."
@doc("Provisioning status of the resource.")
enum GenevaActionsExtensionProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
