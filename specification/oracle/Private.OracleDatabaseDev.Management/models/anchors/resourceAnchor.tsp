using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.OracleDatabaseDev;

@added(Versions.v20250301_preview)
@doc("Resource Anchor model.")
model ResourceAnchor is TrackedResource<ResourceAnchorProperties> {
  ...ResourceNameParameter<ResourceAnchor>;
}

@added(Versions.v20250301_preview)
@doc("Resource Anchor properties.")
model ResourceAnchorProperties {
  @doc("OCI Resource Anchor Metadata")
  @visibility("read")
  ociResourceAnchorMetadata?: OciResourceAnchorMetadata;

  @doc("Display Name")
  @visibility("create", "read", "update")
  displayName?: string;

  @doc("ResourceAnchor lifecycle state")
  @visibility("read")
  lifecycleState?: ResourceAnchorLifecycleState;

  @doc("Additional information about the current lifecycle state.")
  @visibility("read")
  lifecycleDetails?: string;

  @doc("ResourceAnchor provisioning state")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("ResourceAnchor SetupMode")
  @visibility("create", "read")
  setupMode: ResourceAnchorSetupMode;
}

@added(Versions.v20250301_preview)
@doc("ResourceAnchor lifecycle state enum")
union ResourceAnchorLifecycleState {
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
@doc("ResourceAnchor SetupMode enum")
union ResourceAnchorSetupMode {
  @doc("When passed, compartment will be created on-behalf of customer and bind to this resource anchor")
  AutoBind: "AutoBind",

  @doc("When passed, compartment will not be created and later customer can bind existing compartment.")
  NoAutoBind: "NoAutoBind",

  string,
}

@added(Versions.v20250301_preview)
@doc("OCI Resource Anchor Metadata")
model OciResourceAnchorMetadata {
  @doc("Resource anchor OCID")
  @visibility("read")
  ociResourceAnchorId?: Ocid;

  @doc("OCI Subscription OCID")
  @visibility("read")
  ociSubscriptionId: Ocid;

  @doc("Oracle Cloud Infrastructure region")
  @visibility("read")
  ociRegion?: string;

  @doc("Oracle Cloud Infrastructure compartment Id (ocid) where network Anchor lives")
  @visibility("read")
  compartmentId?: Ocid;

  @doc("Oracle Cloud Infrastructure compartment Id (ocid) which was created or linked by customer with resource anchor. This compartmentId is different from where resource Anchor lives")
  @visibility("read")
  linkedCompartmentId?: Ocid;

  @doc("The date and time the resource anchor was updated in Oracle Cloud Infrastructure")
  @visibility("read")
  timeUpdated?: utcDateTime;
}
