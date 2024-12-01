import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.Eds")
@service({
  title: "Microsoft.Eds",
  version: "2023-03-02-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Eds;
interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/cadl-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@minValue(1)
scalar ProductQuantity extends int32;

@doc("An Order request.")
model OrderRequest is TrackedResource<OrderRequestProperties> {
  @doc("Order request API details")
  @pattern("^[0-9]{3,12}$")
  @key("orderRequestId")
  @segment("orderRequests")
  @visibility("read")
  @path
  name: string;
}
  
@armResourceOperations
interface OrderRequests {
  get is ArmResourceRead<OrderRequest>;
  create is ArmResourceCreateOrUpdateAsync<OrderRequest>;
  update is ArmResourcePatchSync<OrderRequest, OrderRequestProperties>;
  delete is ArmResourceDeleteSync<OrderRequest>;
  listByResourceGroup is ArmResourceListByParent<OrderRequest>;
  listBySubscription is ArmListBySubscription<OrderRequest>;
}

@doc("Order request properties.")
model OrderRequestProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;  
  @doc("Big Catalog Products detail like product Id, SkuId, etc.")
  @extension("x-ms-identifiers",[])
  @minItems(1)
  orderLineItemRequests:OrderLineItemRequest[];       
}

@doc("Order Line Item details.")
model OrderLineItemRequest
{
    @doc("UPN associated with Big Catalog XDK product.")
    productCode:string;
	@doc("Big Catalog Product Identifier.")
	productId:string;
	@doc("SKU Identifier")
	skuId:string;
	@doc("Quantity being bought.")
	quantity:ProductQuantity;
	@visibility("read")
	@doc("Response Status Code.")
    lineitemPurchaseStatus?: string;
	@visibility("read")
	@doc("Purchase Status Message.")
    purchaseMessage?: string;
    @visibility("read")
	@doc("Transaction Identifier for each line item in Guid.")
    transId?: string;	
}