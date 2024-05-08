import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.SoftwarePlan Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.SoftwarePlan management service",
})
@versioned(Microsoft.SoftwarePlan.Versions)
namespace Microsoft.SoftwarePlan;

/** The available API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

/** SoftwareOrder resource */
model SoftwareOrder is TrackedResource<SoftwareOrderProperties> {
  /** Name of softwareOrder */
  @key("softwareOrderName")
  @path
  @segment("softwareOrders")
  @pattern("/^[a-zA-Z0-9-]{3,24}$/")
  name: string;
}

/** SoftwareOrder properties */
model SoftwareOrderProperties {
  /** Unique identifier for the product purchased */
  @visibility("create", "read")
  productCode: string;

  /** Quantity of the product purchased */
  @visibility("create", "read")
  quantity: int32;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /** Date when the order benefit should start. Format : 2023-02-01T01:01:01.1075056Z */
  @visibility("create", "read")
  startAt?: string;

  /** Date when the order benefit should end. Format : 2024-02-01T01:01:01.1075056Z */
  @visibility("create", "read")
  endAt?: string;

  /** If set to true, will auto renew at the end of the current term */
  @visibility("create", "read", "update")
  autoRenew?: boolean;

  /** Contains information about renewal of this product */
  @visibility("read", "update")
  renewal?: SoftwareOrderRenewalProperties;

  /** Friendly name for the order */
  @visibility("create", "read")
  displayName: string;
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",

  /** The resource provisioning request has been accepted. */
  Accepted: "Accepted",
}

/** productCode to be used during renewal */
model SoftwareOrderRenewalProperties {
  /** productCode to be used during renewal */
  productCode: string;
}

/** Provisioned software key info */
model SoftwareKey {
  /** Type of key provisioned */
  keyType: string;

  /** Status of key provisioned */
  keyStatus: string;

  /** 5x5 software activation key */
  keyValue: string;

  /** URL to download software */
  downloadLink?: string;

  /** Count of purchased keys */
  purchasedCount: int32;

  /** Count of activated keys */
  activationCount: int32;

  /** Catalog product Id for this software */
  productId?: string;

  /** Catalog sku Id for this software */
  skuId?: string;
}

// not needed because we are partial manifest ?
interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SoftwareOrders {
  get is ArmResourceRead<SoftwareOrder>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SoftwareOrder>;
  update is ArmResourcePatchSync<SoftwareOrder, SoftwareOrderProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<SoftwareOrder>;
  listByResourceGroup is ArmResourceListByParent<SoftwareOrder>;
  listBySubscription is ArmListBySubscription<SoftwareOrder>;

  /** List software keys provisioned for this order */
  listKeys is ArmResourceActionSync<SoftwareOrder, void, SoftwareKey[]>;
  cancel is ArmResourceActionAsync<SoftwareOrder, void, SoftwareOrder>;
}
