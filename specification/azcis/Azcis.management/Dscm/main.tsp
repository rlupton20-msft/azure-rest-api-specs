import "../versions.tsp";
import "./dsmsallowlist.tsp";
import "./dstsserviceaccount.tsp";
import "./dstsapplication.tsp";
import "./dsmsrootfolder.tsp";
import "./dstsserviceclientidentity.tsp";
import "./jitpolicyset.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
})
@doc("dscm Service")
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union DscmProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
