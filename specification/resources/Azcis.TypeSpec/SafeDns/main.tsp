import "./create/aaaarecordset.tsp";
import "./create/arecordset.tsp";
import "./update/updateaaaarecordset.tsp";
import "./update/updatearecordset.tsp";
import "./append/appendaaaarecordset.tsp";
import "./append/appendarecordset.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
  version: "2023-08-22-preview",
})
@doc("SafeDns Service")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

// AAAA Record Common Models
@doc("AAAA Record type model")
model AaaaRecord {
    @doc("Gets or sets the IPv6 Address in String format")
    ipV6Address: string;
}

// A Record Common Models
@doc("A Record type model")
model Arecord {
    @doc("Gets or sets the IPv4 Address in String format")
    ipV4Address: string;
}
// Common Models
@doc("RecordSetOwner type model")
model RecordSetOwner {
    @doc("Gets or sets ServiceTreeId")
    serviceTreeId: string;

    @doc("Gets or sets ContactEmail")
    contactEmail: string;
}

@doc("Provisioning status of the resource.")
enum DnsNamespaceManagerProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
