import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Science.Management.Shared/all.tsp";
import "./supercomputer.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("NodePool tracked resource")
@parentResource(Supercomputer)
model NodePool is TrackedResource<NodePoolProperties> {
  ...ResourceNameParameter<NodePool>;
}

@doc("NodePool properties")
model NodePoolProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The subnet.")
  @visibility("read", "create")
  subnetId: string; // TODO Make resource identifier

  @doc("The Sku.")
  @visibility("read", "create")
  vmSku: string; // TODO: Make arm sku, which will we support (allow list)?

  @doc("The number of nodes.")
  @visibility("read", "create", "update")
  maxNodeCount: int32;
}

@armResourceOperations
interface NodePools {
  get is ArmResourceRead<NodePool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NodePool>;
  update is ArmResourcePatchSync<NodePool, NodePoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NodePool>;
  listByResourceGroup is ArmResourceListByParent<NodePool>;
  listBySubscription is ArmListBySubscription<NodePool>;
}
