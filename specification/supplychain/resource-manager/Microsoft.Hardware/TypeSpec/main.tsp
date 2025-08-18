import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Hardware Resource Provider",
  version: "2023-07-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Hardware;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A Hardware Resource Provider Order resource")
model Order is TrackedResource<OrderProperties> {
  @doc("Order Name")
  @key("orderId")
  @path
  @segment("orders")
  name: string;
}

@doc("Forward Order")
model OrderProperties {
  @doc("Customer PurchaseOrder")
  customerOrder?: CustomerOrder;

  @doc("Type of action Pre-Fulfill/Fulfill")
  @visibility("read")
  action?:string;

  @doc("Order status")
  status?: OrderStatus;

  @doc("Order line details")
  @OpenAPI.extension("x-ms-identifiers",["id"])
  orderLines:OrderLine[];

  @doc("Billing Information")
  billingInformation?:BillingInformation;

  @doc("Currency for the order")
  currency?:string;

  @doc("Market - country code for Order")
  market?:string;

  @doc("Language - language code for Order")
  language?:string;

  @doc("Reservation for order if applicable")
  reservationId?:string;

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Customer PurchaseOrder")
model CustomerOrder {
  @doc("Customer PurchaseOrder Id")
  id: string;

  @doc("Customer PurchaseOrder Date Time")
  createdDateTime: utcDateTime;
}

@doc("Billing Details for Order")
model BillingInformation {
  @doc("Credit Card Auth Token - if blank defaults to Invoicing")
  authorizationToken: string;

  @doc("base64 Risk Token")
  riskToken: string;
}

@doc("Order Line")
model OrderLine {
  @doc("Order lineId")
  id: int64;

  @doc("Order line status")
  @visibility("read")
  status?: OrderLineStatus;

  @doc("Billing State")
  @visibility("read")
  billingState?: BillingState;
  
  @doc("Order line created date time")
  @visibility("read")
  createdDateTime?: utcDateTime;
  
  @doc("Order line qty")
  quantity: OrderLineQty;
  
  @doc("order line Product")
  product: Product;
  
  @doc("order line fulfillment instructions")
  lineFulfillmentInstruction?: LineFulfillmentInstruction;

  @doc("line level Price")
  price:Price;

  @doc("shipTo Address")
  shipTo: ShipTo;

  @doc("Shipping Method")
  shippingMethod?: ShippingMethod;

  @doc("Requested Delivery Date Time")
  requestedDeliveryDateTime?:utcDateTime;

  @doc("Cancellation Reason")
  cancellationReason?:string;

  @doc("Cancelled By User details")
  cancelledBy?:string;

  @doc("Estimated Delivery Date Time")
  estimatedDeliveryDateTime?:utcDateTime;

  @doc("Estimated Shipped Date Time")
  estimatedShippedDateTime?:utcDateTime;
}

@doc("Order Line Qty")
model OrderLineQty {
  @doc("Order lineId pending quantity")
  pending: int64;

  @doc("Order lineId in-progress quantity")
  @visibility("read")
  inProgress?: int64;
  
  @doc("Order lineId fulfilled quantity")
  @visibility("read")
  fulfilled?:int64;
  
  @doc("Order lineId quantity pending warranty provisioning")
  @visibility("read")
  pendingProvisioning?: int64;
  
  @doc("Order lineId warranty provisioned quantity")
  @visibility("read")
  provisioned?:int64;
  
  @doc("Order lineId quantity pending cancellation")
  @visibility("read")
  pendingCancel?:int64;
  
  @doc("Order lineId cancelled Quantity")
  @visibility("read")
  cancelled?:int64;
  
  @doc("Order lineId quantity pending return")
  @visibility("read")
  pendingReturn?:int64;
  
  @doc("Order lineId returned Quantity")
  @visibility("read")
  returned?:int64;
}

@doc("Order line Product")
model Product {
  @doc("ProductId")
  id: string;

  @doc("ProductId Type")
  type:ProductIdType;

  @doc("BundleProductId")
  bundleProductId?: string;

  @doc("BundleInstanceId")
  bundleInstanceId?: string;

  @doc("BundleSlotId")
  bundleSlotId?: int64;
}

@doc("Order line fulfillment instructions")
model LineFulfillmentInstruction {
  @doc("Device line referred to by the warranty line.")
  referenceDeviceLine?: int64;

  @doc("Serial Numbers")
  serialNumbers?: int64[];
}

@doc("Order line Price")
model Price {
  @doc("Price per Unit")
  unitAmount: float64;

  @doc("Shipping Cost for the line")
  shippingCost?: float64;

  @doc("Tax for this line")
  taxes?: Tax[];

  @doc("Fees for this line")
  @OpenAPI.extension("x-ms-identifiers",["type"])
  fees?: Fee[];
}

@doc("Fee model")
model Fee{
  @doc("Fee charged")
  amount: float64;

  @doc("Fee Type")
  type: FeeType;
}

@doc("Tax model")
model Tax{
  @doc("Tax charged")
  amount: float64;
  
  @doc("Tax Type")
  type: TaxType;

  @doc("Categorization of the taxation system")
  class?: string;
  
  @doc("Specific title assigned to the tax entity")
  name?: string;

  @doc("Level of governing authority")
  jurisdictionEntity?: string;

  @doc("Name of the jurisdiction")
  jurisdictionName?: string;

  @doc("Tax Rate")
  rate?: float64;
}

@doc("ShipTo Id")
model ShipTo{
  @doc("ShipTo Id")
  id: string;

  @doc("ShipTo Type")
  type: ShipToIdType;
}

@armResourceOperations
interface Orders
{
  @Autorest.example("./examples/Orders_Get.json","OrderById")
  get is ArmResourceRead<Order>;

  @Autorest.example("./examples/Orders_Create.json","CreateOrder")
  create is ArmResourceCreateOrUpdateAsync<Order>;
  
  @Autorest.example("./examples/Orders_Update.json","UpdateOrder")
  update is ArmResourcePatchSync<Order, OrderProperties>;
  
  @Autorest.example("./examples/Orders_Delete.json","DeleteOrder")
  delete is ArmResourceDeleteSync<Order>;
  
  @Autorest.example("./examples/Orders_ListByResourceGroup.json","GetByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Order>;
  
  @Autorest.example("./examples/Orders_ListBySubscription.json","GetBySubscription")
  listBySubscription is ArmListBySubscription<Order>;
}

@doc("ProductId Type")
enum ProductIdType{
  @doc("UPN in Big-Catalog")
  UPN,
  @doc("Product, SKU, Availability in Big-Catalog")
  PSA,
  @doc("MS Product Identifier (3x5 SKU)")
  FulfillmentProductId
}

@doc("Shipping Method")
enum ShippingMethod{
  @doc("Ground shipping")
  Ground,
  @doc("Two day shipping")
  TwoDay,
  @doc("Three day shipping")
  ThreeDay,
  @doc("Sustainable shipping")
  Sustainable,
  @doc("Street date shipping")
  StreetDate,
  @doc("APO FPO shipping")
  ApoFpo
}

@doc("shipToId Type")
enum ShipToIdType{
  @doc("Modern Commerce API Business Location")
  BusinessLocation,
  @doc("Partner External-Id")
  ExternalId
}

@doc("Fee Type")
enum FeeType{
  @doc("Recycling Fee")
  Recycling
}

@doc("Tax Type")
enum TaxType{
  @doc("Tax on Unit amount for Product cost")
  Unit,
  @doc("Tax on Shipping cost")
  Shipping
}

@doc("Order Status")
enum OrderStatus{
  @doc("Order is pending")
  Pending,
  @doc("Order is Created")
  Created,
  @doc("Order is Confirmed")
  Confirmed,
  @doc("Order is PartiallyConfirmed")
  PartiallyConfirmed,
  @doc("Order is pending cancellation")
  PendingCancel,
  @doc("Order is Ready to Provision cannot be cancelled")
  PendingProvisioning,
  @doc("Order is PartiallyProvisioned")
  PartiallyProvisioned,
  @doc("Order is Provisioned")
  Provisioned,
  @doc("Order is Ready to Ship cannot be cancelled")
  PendingShipment,
  @doc("Order is PartiallyShipped")
  PartiallyShipped,
  @doc("Order is Shipped")
  Shipped
}

@doc("Order Line Status")
enum OrderLineStatus{
  @doc("Order is pending")
  Pending,
  @doc("Order is in-progress")
  InProgress,
  @doc("Order is fulfilled")
  Fulfilled,
  @doc("Order is cancelled")
  Cancelled,
  @doc("Order is returned")
  Returned
}

@doc("Billing State")
enum BillingState {
  @doc("The default state, initialized or reset after a failed operation")
  Pending,
  @doc("The payment is pending capture.")
  PendingCapture,
  @doc("The payment has been captured successfully.")
  Captured,
  @doc("The payment capture failed.")
  CaptureFailed,
  @doc("The payment is pending a refund.")
  PendingRefund,
  @doc("The payment has been refunded.")
  Refunded
}

@doc("Provisioning State")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Order is pending")
  Pending

}

alias DefaultProviderNamespace = {
  @path
  @TypeSpec.Rest.segment("providers")
  @doc("The provider namespace for the resource.")
  provider: "Microsoft.Hardware";
};

@armResourceOperations
interface OrderPreviewInterface {
@armResourceCollectionAction
  @armProviderNameValue
  @doc("Implements orderPreview operations")
  @Autorest.example("./examples/Orders_Preview.json","OrderPreview")
  @TypeSpec.Rest.action("orderPreview")
  @post
  op orderPreview(
    ...SubscriptionIdParameter,
    ...DefaultProviderNamespace,
    ...ApiVersionParameter,

    @doc("The orderPreview request")
    @body
    body: Order,
  ): Order | ErrorResponse;
}
