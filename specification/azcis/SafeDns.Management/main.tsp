import "../versions.tsp";
import "./create/arecordset.tsp";
import "./update/updatearecordset.tsp";
import "./append/appendarecordset.tsp";

import "./create/aaaarecordset.tsp";
import "./update/updateaaaarecordset.tsp";
import "./append/appendaaaarecordset.tsp";

import "./create/srvrecordset.tsp";
import "./update/updatesrvrecordset.tsp";
import "./append/appendsrvrecordset.tsp";

import "./create/txtrecordset.tsp";
import "./update/updatetxtrecordset.tsp";
import "./append/appendtxtrecordset.tsp";

import "./create/childzonedelegation.tsp";
import "./update/updatechildzonedelegation.tsp";

import "./create/cnamerecordset.tsp";
import "./update/updatecnamerecordset.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("SafeDns Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

// A Record Set Models
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("A Record type model")
model ARecord {
  @doc("Gets or sets the IPv4 Address in String format")
  ipV4Address: string;
}

// AAAA Record Set Models
@doc("AAAA Record type model")
model AaaaRecord {
  @doc("Gets or sets the IPv6 Address in String format")
  ipV6Address: string;
}

// CName Record Set Models
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("Represents an CNAME Record")
model CNameRecord {
  @doc("Gets or sets the Canonical Name")
  cName: string;
}

// Srv Record Set Models
@doc("Represents a SRV Record")
model SrvRecord {
  @doc("Gets or sets the SRV record Priority in Integer format.")
  priority: int32;

  @doc("Gets or sets the SRV record Weight in Integer format.")
  weight: int32;

  @doc("Gets or sets the SRV record Port in Integer format.")
  port: int32;

  @doc("Gets or sets the SRV record Target in String format.")
  target: string;
}

// Txt Record Set Models
@doc("Represents an TXT Record")
model TxtRecord {
  @doc("Gets or sets the TXT record in String format.")
  txt: Array<string>;
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
union DnsNamespaceManagerProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
