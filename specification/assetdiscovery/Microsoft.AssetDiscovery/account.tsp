import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AssetDiscovery;

/** Account resource */
model Account is TrackedResource<AccountProperties> {
  /** Name of Account */
  @doc("The name of the account")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("accountName")
  @segment("accounts")
  @path
  name: string;
}

/** Account properties */
model AccountProperties {
  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Accounts {
  get is ArmResourceRead<Account>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Account>;
  update is ArmResourcePatchSync<Account, AccountProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Account>;
  listByResourceGroup is ArmResourceListByParent<Account>;
  listBySubscription is ArmListBySubscription<Account>;
}
