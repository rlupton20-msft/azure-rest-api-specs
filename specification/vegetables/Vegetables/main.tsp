import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Vegetables")
@service({
  title: "Microsoft.Vegetables",
  version: "2023-11-17-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Vegetables;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the Vegetables Basket.")
model BasketProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A sdtylish container capable of holding various vegetables.")
model Basket is TrackedResource<BasketProperties> {
  @doc("The name of the basket.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("basketName")
  @segment("baskets")
  @path
  name: string;
}

@armResourceOperations
interface Baskets {
  get is ArmResourceRead<Basket>;
  create is ArmResourceCreateOrUpdateAsync<Basket>;
  update is ArmResourcePatchSync<Basket, BasketProperties>;
  delete is ArmResourceDeleteSync<Basket>;
  listByResourceGroup is ArmResourceListByParent<Basket>;
  listBySubscription is ArmListBySubscription<Basket>;
}

@doc("Details of the Vegetables Baskets/Carrots.")
model CarrotProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("An orange root vegetable commonly associated with rabbits.")
@parentResource(Basket)
model Carrot is TrackedResource<CarrotProperties> {
  @doc("The name of the carrot.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("carrotName")
  @segment("carrots")
  @path
  name: string;
}

@armResourceOperations
interface Carrots {
  get is ArmResourceRead<Carrot>;
  create is ArmResourceCreateOrUpdateAsync<Carrot>;
  update is ArmResourcePatchSync<Carrot, CarrotProperties>;
  delete is ArmResourceDeleteSync<Carrot>;
  listByResourceGroup is ArmResourceListByParent<Carrot>;
  listBySubscription is ArmListBySubscription<Carrot>;
}
