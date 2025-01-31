using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.OracleDatabaseDev;

@added(Versions.v20250301_preview)
@doc("Network Anchor resource model.")
model NetworkAnchor is TrackedResource<NetworkAnchorProperties> {
  ...ResourceNameParameter<NetworkAnchor>;
}

@added(Versions.v20250301_preview)
@doc("Network Anchor properties")
model NetworkAnchorProperties {
  @doc("NetworkAnchor OCID")
  @visibility("read")
  ocid?: Ocid;

  @doc("Display Name")
  @visibility("create", "read", "update")
  displayName?: string;

  @doc("Corresponding resource anchor OCID")
  @visibility("read")
  resourceAnchorOcid?: Ocid;

  @doc("Corresponding resource anchor Azure ID")
  @visibility("create", "read", "update")
  resourceAnchorId?: string;

  @doc("NetworkAnchor lifecycle state")
  @visibility("read")
  lifecycleState?: NetworkAnchorLifecycleState;

  @doc("NetworkAnchor provisioning state")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("VNET for network connectivity")
  @visibility("create", "read", "update")
  vnetId?: VnetId;

  @doc("Client subnet")
  @visibility("create", "read", "update")
  subnetId?: SubnetId;

  @doc("Oracle Cloud Infrastructure DNS label. This is optional if DNS config is provided.")
  @visibility("create", "read", "update")
  dnsLabel?: string;

  @doc("DNS domain ip mapping forwarding configuration")
  @visibility("create", "read", "update")
  @extension("x-ms-identifiers", [])
  dnsForwardingConfig?: DnsForwardingConfig[];

  @doc("Full custom domain name. If this field is passed dnsLabel will be ignored")
  @visibility("create", "read", "update")
  customDomainName?: string;

  @doc("Client primary cidr block")
  @visibility("create", "read", "update")
  cidrBlock?: string;

  @doc("Client backup cidr block")
  @visibility("create", "read", "update")
  backupCidrBlock?: string;

  @doc("Oracle Cloud Infrastructure VCN OCID")
  @visibility("read")
  vcnOcid?: Ocid;

  @doc("Indicates whether OCI networking counterparts should be auto-created")
  @visibility("create")
  setupMode: NetworkAnchorSetupMode;
}

@added(Versions.v20250301_preview)
@doc("NetworkAnchor lifecycle state enum")
union NetworkAnchorLifecycleState {
  @doc("Indicates that resource in Connected state")
  Connected: "Connected",

  @doc("Indicates that resource in Disconnected state")
  Disconnected: "Disconnected",

  @doc("Indicates that resource in Connecting state")
  Connecting: "Connecting",

  @doc("Indicates that resource in Active state")
  Active: "Active",

  @doc("Indicates that resource in Error state")
  Error: "Error",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in NeedsAttention state")
  NeedsAttention: "NeedsAttention",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  @doc("Indicates that resource in Deleting state")
  Deleting: "Deleting",

  @doc("Indicates that resource in Deleted state")
  Deleted: "Deleted",

  string,
}

@added(Versions.v20250301_preview)
@doc("DNS domain to ip mapping forwarding configuration")
model DnsForwardingConfig {
  @doc("Domain name")
  domain: string;

  @doc("IP address to resolve domain to")
  ipAddress: string;
}

@added(Versions.v20250301_preview)
@doc("NetworkAnchor SetupMode enum")
union NetworkAnchorSetupMode {
  @doc("When passed, compartment will be created on-behalf of customer and bind to this network anchor")
  AutoBind: "AutoBind",

  @doc("When passed, compartment will be created on-behalf of customer and bind to this network anchor")
  NoAutoBind: "NoAutoBind",

  string,
}
