import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
namespace Microsoft.Contoso;

/** BilledItem resource */
@added(Versions.v2025_04_01_preview)
model BilledItem is TrackedResource<BilledItemProperties> {
  ...ResourceNameParameter<BilledItem>;
}

/** BilledItem properties */
@added(Versions.v2025_04_01_preview)
model BilledItemProperties {
  /** The billing data for this billed item */
  billingData?: BillingData;
  
  /** The provisioning state of the resource */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** BilledItem properties for update */
@added(Versions.v2025_04_01_preview)
model BilledItemUpdateProperties {
  /** The billing data for this billed item */
  billingData?: BillingData;
}

/** Billing data details */
@added(Versions.v2025_04_01_preview)
model BillingData {
  /** The system identifier */
  systemId?: string;
  
  /** The state of the billing */
  state?: string;
  
  /** The product code */
  productCode: string;
  
  /** The product token */
  productToken?: string;
  
  /** The billing token */
  billingToken?: string;
  
  /** The quantity */
  quantity?: float64 = 1;
  
  /** The start date */
  startDate?: utcDateTime;
  
  /** The end date */
  endDate?: utcDateTime;
  
  /** The schedule details */
  schedule?: BillingSchedule;
}

/** Billing schedule details */
@added(Versions.v2025_04_01_preview)
model BillingSchedule {
  /** The next invoice date */
  @visibility(Lifecycle.Read)
  nextInvoiceDate?: utcDateTime;
  
  /** The renewal type */
  renewal?: string;
  
  /** The scheduled changes */
  changes?: BillingChange[];
}

/** Billing change details */
@added(Versions.v2025_04_01_preview)
model BillingChange {
  /** The product code */
  productCode?: string;
  
  /** The product token */
  productToken?: string;
  
  /** The billing token */
  billingToken?: string;
  
  /** The end date */
  endDate?: utcDateTime;
  
  /** The quantity */
  quantity?: float64;
  
  /** When the change is effective */
  effective?: string = "renewal";
}

@added(Versions.v2025_04_01_preview)
@armResourceOperations
interface BilledItems {
  get is ArmResourceRead<BilledItem>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BilledItem>;
  update is ArmResourcePatchAsync<BilledItem, BilledItemUpdateProperties>;
  delete is ArmResourceDeleteSync<BilledItem>;
  listByResourceGroup is ArmResourceListByParent<BilledItem>;
  listBySubscription is ArmListBySubscription<BilledItem>;
}