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
  /** The offer details for this billed item */
  offer?: Offer;
  
  /** The provisioning state of the resource */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** BilledItem properties */
@added(Versions.v2025_04_01_preview)
model BilledItemUpdateProperties  {
  /** The offer details for this billed item */
  offer?: Offer;
}

/** Offer details */
@added(Versions.v2025_04_01_preview)
model Offer {
  /** The billing resource identifier */
  billingResourceId?: string;

  /** The product code */
  productCode?: string;

  /** The product token */
  productToken?: string;

  /** The billing token */
  billingToken?: string;

  /** The state of the offer */
  state?: string;

  /** The quantity of the offer */
  quantity?: float64;

  /** Whether the offer auto-renews */
  autoRenew?: boolean;

  /** The start date of the offer */
  startDate?: utcDateTime;

  /** The end date of the offer */
  endDate?: utcDateTime;

  /** The next charge date of the offer */
  nextCharge?: utcDateTime;

  /** The schedule details for the offer */
  schedule?: OfferSchedule;
}

/** Offer schedule details */
@added(Versions.v2025_04_01_preview)
model OfferSchedule {
  /** The product code of the schedule */
  productCode?: string;

  /** The quantity of the schedule */
  quantity?: float64;

  /** When the schedule is effective */
  effective?: string;
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