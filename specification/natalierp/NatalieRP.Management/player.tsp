import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.NatalieRP;

/** Player resource */
model Player is TrackedResource<PlayerProperties> {
  ...ResourceNameParameter<Player>;
}

/** Player properties */
model PlayerProperties {
  /** Name of Player */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(10)
  name: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Players {
  get is ArmResourceRead<Player>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Player>;
  update is ArmResourcePatchSync<Player, PlayerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Player>;
  listByResourceGroup is ArmResourceListByParent<Player>;
  listBySubscription is ArmListBySubscription<Player>;
}