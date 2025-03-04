import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerAppendARecordSet properties")
model DnsNamespaceManagerAppendARecordSetResourceProperties {
  @doc("Gets or sets the array of A Records")
  @extension("x-ms-identifiers", [])
  aRecords: ARecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Gets or sets the owning team's ServiceTree Id and Contact Email")
  recordSetOwner?: RecordSetOwner;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerAppendARecordSet Resource")
model DnsNamespaceManagerAppendARecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendARecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAppendARecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Interface types must use PascalCase"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerAppendARecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerAppendARecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerAppendARecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerAppendARecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerAppendARecordSetResource>;
}
