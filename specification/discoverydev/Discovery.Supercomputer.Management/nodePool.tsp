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
  @doc("Standard_NC96ads_A100_v4 GPU-optimized Azure VM Sku")
  Standard_NC96ads_A100_v4: "Standard_NC96ads_A100_v4",

  @doc("Standard_NC48ads_A100_v4 GPU-optimized Azure VM Sku")
  Standard_NC48ads_A100_v4: "Standard_NC48ads_A100_v4",

  @doc("Standard_NC24ads_A100_v4 GPU-optimized Azure VM Sku")
  Standard_NC24ads_A100_v4: "Standard_NC24ads_A100_v4",

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
  listBySupercomputer is ArmResourceListByParent<NodePool>;
  listBySubscription is ArmListBySubscription<NodePool>;
}
