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
  offer?: Record<unknown>;

  /** The billing data for this billed item */
  billingData?: Record<unknown>;

  /** The unique identifier for this billed item */
  itemId?: string;

  /** Number of billable units */
  billableUnits?: float32;

  /** The provisioning state of the resource */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_04_01_preview)
@armResourceOperations
interface BilledItems {
  get is ArmResourceRead<BilledItem>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<BilledItem>;
  update is ArmResourcePatchSync<BilledItem, BilledItemProperties>;
  delete is ArmResourceDeleteSync<BilledItem>;
  listByResourceGroup is ArmResourceListByParent<BilledItem>;
  listBySubscription is ArmListBySubscription<BilledItem>;
}