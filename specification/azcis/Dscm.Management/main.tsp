import "../versions.tsp";
import "./dsmsallowlist.tsp";
import "./dsmsrootfolder.tsp";
import "./dstsapplication.tsp";
import "./dstsserviceaccount.tsp";
import "./dstsserviceclientidentity.tsp";
import "./dstsserviceclientidentitygroup.tsp";
import "./dstsserviceclientidentitygroupmanaged.tsp";
import "./dstsserviceclientidentitygroupsubjectnamebased.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("dscm Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union DscmProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
