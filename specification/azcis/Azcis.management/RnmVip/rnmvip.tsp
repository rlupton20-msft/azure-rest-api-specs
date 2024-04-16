import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("rnmVip properties")
model RnmVipResourceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("Unique name of a RnmVip resource item.")
  resourceName: string;

  @doc("Gets or sets the value of rnm subscription Guid. Every vip allocated by rnm needs to be associated with a subscription. Rnm team created subscriptions for different teams.")
  subscriptionId: string;

  @doc("Gets or sets the value of vip reservation Id. Every vip allocated by rnm has a reservation Id. This is an optional field for Static IP reservation. In this case, if the reservation is already present then the system will mark reservation as successful without any duplicate reservation. E.g. FF03EB76-BA3D-4892-BD40-E42EFEE3DF67")
  reservationId?: string;

  @doc("Gets or sets the value of VIP address Family. It is an optional property. E.g. InterNetwork.")
  addressFamily?: string;

  @doc("Gets or sets the value of VIP Accessibility. It is an optional property. E.g. Public.")
  vipAccessibility?: string;

  @doc("Gets or sets the value of FirstPartyUsage tag. It is an optional tag of a vip. E.g. \"/Storage\"")
  firstPartyUsageTag?: string;

  @doc("Gets or sets the value of FirstPartyUsage tag for zonal vips. It is an optional tag of a vip. E.g. \"/AzureStorageGeneralInRnm\"")
  zonalFirstPartyUsageTag?: string;

  @doc("Gets or sets the value of Scope tag. It is an optional tag of a vip. E.g. \"TransitAnycast\"")
  scopeTag?: string;

  @doc("Gets or sets the flag indicating whether AvailabilityZone tag is required. AvailabilityZone tag value depends on the cluster, so it is not able to provide a value in template. AZ of a cluster can be found in file \\\\reddog\\Builds\\branches\\dcmt_latest_amd64\\Datacenter\\AZs.xml")
  availabilityZonal?: boolean;

  @doc("Gets or sets the IP address to be reserved. E.g. Any IPv4 or IPv6 address.")
  ipAddress?: string;

  @doc(" Gets or sets flag to use RNM RP VIP v2.")
  useRnmVipRpVersion2?: boolean;

  @doc("Gets or sets Availability Zone.")
  availabilityZone?: string;

  @doc("Gets or sets RNM VIP Metadata.")
  vipMetaData?: VipMetaData;

  @doc("Gets or sets the IP address to be reserved.")
  @extension("x-ms-identifiers", [])
  vipTags?: Array<RnmVipTag>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: RnmVipProvisioningState;
}

@doc("RNM VIP Metadata to capture details related VIP.")
model VipMetaData {
  @doc("Gets or sets the IP address.")
  ipAddress?: string;

  @doc("Gets or sets the VIP range.")
  vipRange?: string;

  @doc("Gets or sets the Infrastructure tenant VIP range Index.")
  infraStructureTenantVipRangeIndex?: string;

  @doc("Gets or sets the VIP offset.")
  vipOffset?: string;
}

@doc("RNM VIP Tag class to capture VIP Tags")
model RnmVipTag {
  @doc("Gets or sets the VIP tag type. E.g. \"FirstPartyUsage\".")
  type: string;

  @doc("Gets or sets the VIP tag value.")
  value: string;
}

@doc("rnmVips Resource")
model RnmVipResource
  is TrackedResource<RnmVipResourceProperties> { // This can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("rnmVips") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface RnmVip {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<RnmVipResource>;
  listBySubscription is ArmListBySubscription<RnmVipResource>;
  listByResourceGroup is ArmResourceListByParent<RnmVipResource>;
  get is ArmResourceRead<RnmVipResource>;
}
