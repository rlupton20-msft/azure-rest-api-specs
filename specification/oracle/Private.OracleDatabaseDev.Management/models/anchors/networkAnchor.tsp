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
  ...AvailabilityZonesProperty;
}

@added(Versions.v20250301_preview)
@doc("Network Anchor properties")
model NetworkAnchorProperties {
  @doc("Display Name")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  displayName?: string;

  @doc("Corresponding resource anchor Azure ID")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceAnchorId: string;

  @doc("NetworkAnchor lifecycle state")
  @visibility(Lifecycle.Read)
  lifecycleState?: NetworkAnchorLifecycleState;

  @doc("Additional information about the current lifecycle state.")
  @visibility(Lifecycle.Read)
  lifecycleDetails?: string;

  @doc("NetworkAnchor provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: AzureResourceProvisioningState;

  @doc("VNET for network connectivity")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  vnetId: VnetId;

  @doc("Client subnet")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subnetId: SubnetId;

  @doc("Oracle Cloud Infrastructure DNS label. This is optional if DNS config is provided.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dnsLabel?: string;

  @doc("Full custom domain name. If this field is passed dnsLabel will be ignored")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  customDomainName?: string;

  @doc("Client primary cidr block")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  cidrBlock?: string;

  @doc("Client backup cidr block")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  backupCidrBlock?: string;

  @doc("Indicates whether OCI networking counterparts should be auto-created")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  setupMode: NetworkAnchorSetupMode;

  @doc("OCI Network Anchor Metadata")
  @visibility(Lifecycle.Read)
  ociNetworkAnchorMetadata?: OciNetworkAnchorMetadata;
}

@added(Versions.v20250301_preview)
@doc("NetworkAnchor lifecycle state enum")
union NetworkAnchorLifecycleState {
  @doc("Indicates that resource in Creating state")
  Creating: "Creating",

  @doc("Indicates that resource in Active state")
  Active: "Active",

  @doc("Indicates that resource in Inactive state")
  Inactive: "Inactive",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Deleting state")
  Deleting: "Deleting",

  @doc("Indicates that resource in Deleted state")
  Deleted: "Deleted",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  string,
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

@added(Versions.v20250301_preview)
@doc("OCI Network Anchor Metadata")
model OciNetworkAnchorMetadata {
  @doc("NetworkAnchor OCID")
  @visibility(Lifecycle.Read)
  ociNetworkAnchorId?: Ocid;

  @doc("Corresponding resource anchor OCID")
  @visibility(Lifecycle.Read)
  ociResourceAnchorId?: Ocid;

  @doc("Oracle Cloud Infrastructure VCN OCID")
  @visibility(Lifecycle.Read)
  ociVcnId?: Ocid;

  @doc("Oracle Cloud Infrastructure subnet OCID")
  @visibility(Lifecycle.Read)
  ociSubnetId?: Ocid;

  @doc("Oracle Cloud Infrastructure compartment Id (ocid) where network Anchor lives")
  @visibility(Lifecycle.Read)
  compartmentId?: Ocid;

  @doc("Oracle Cloud Infrastructure region")
  @visibility(Lifecycle.Read)
  ociRegion?: string;

  @doc("The date and time the network anchor was updated in Oracle Cloud Infrastructure")
  @visibility(Lifecycle.Read)
  timeUpdated?: utcDateTime;
}
