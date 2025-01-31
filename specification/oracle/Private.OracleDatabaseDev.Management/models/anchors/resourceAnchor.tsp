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
  @doc("ResourceAnchor OCID")
  @visibility("read")
  ocid?: Ocid;

  @doc("Display Name")
  @visibility("create", "read", "update")
  displayName?: string;

  @doc("ResourceAnchor lifecycle state")
  @visibility("read")
  lifecycleState?: ResourceAnchorLifecycleState;

  @doc("ResourceAnchor provisioning state")
  @visibility("read")
  provisioningState?: AzureResourceProvisioningState;

  @doc("ResourceAnchor SetupMode")
  @visibility("create")
  setupMode: ResourceAnchorSetupMode;
}

@added(Versions.v20250301_preview)
@doc("ResourceAnchor lifecycle state enum")
union ResourceAnchorLifecycleState {
  @doc("Indicates that resource in Creating state")
  Creating: "Creating",

  @doc("Indicates that resource in Active state")
  Active: "Active",

  @doc("Indicates that resource in Updating state")
  Updating: "Updating",

  @doc("Indicates that resource in Failed state")
  Failed: "Failed",

  @doc("Indicates that resource in Deleting state")
  Deleting: "Deleting",

  @doc("Indicates that resource in Deleted state")
  Deleted: "Deleted",

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
