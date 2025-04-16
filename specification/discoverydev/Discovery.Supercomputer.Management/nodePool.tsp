import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";
import "./supercomputer.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Supported Azure VM Skus.")
union VmSku {
  @doc("Standard_NC6 GPU-optimized Azure VM Sku with 6 vCPUs")
  Standard_NC6: "Standard_NC6",

  @doc("Standard_NC12 GPU-optimized Azure VM Sku with 12 vCPUs")
  Standard_NC12: "Standard_NC12",

  @doc("Standard_NC24 GPU-optimized Azure VM Sku with 24 vCPUs")
  Standard_NC24: "Standard_NC24",

  string,
}

@doc("NodePool tracked resource")
@parentResource(Supercomputer)
model NodePool is TrackedResource<NodePoolProperties> {
  ...ResourceNameParameter<NodePool>;
}

@doc("NodePool properties")
model NodePoolProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The subnet.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Microsoft.Discovery.Shared.SubnetId;

  @doc("The Sku of the underlying Azure VM.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  vmSku: VmSku;

  @doc("The maximum number of nodes.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  maxNodeCount: int32;
}

@armResourceOperations
interface NodePools {
  get is ArmResourceRead<NodePool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NodePool>;
  update is ArmResourcePatchAsync<NodePool, NodePoolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<NodePool>;
  listByResourceGroup is ArmResourceListByParent<NodePool>;
  listBySubscription is ArmListBySubscription<NodePool>;
}
