import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

@doc("The status of the current operation.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The provisioning resource state.")
  Provisioning,

  @doc("The updating resource state.")
  Updating,

  @doc("The deleting resource state.")
  Deleting,

  @doc("The accepted resource state.")
  Accepted,
}

@doc("The extended location.")
model ExtendedLocation {
  @visibility("read", "create")
  @doc("The extended location type.")
  type?: string;

  @visibility("read", "create")
  @doc("The extended location name.")
  name?: string;
}
