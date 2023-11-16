import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
  version: "2023-08-22-preview",
})
@doc("DnsNamespaceManagerAppendARecordSet Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerAppendARecordSet properties")
model DnsNamespaceManagerAppendARecordSetResourceProperties {
  @doc("Gets or sets the array of A Records")
  aRecords: ARecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Gets or sets the owning team's ServiceTree Id and Contact Email")
  recordSetOwner?: RecordSetOwner;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerAppendARecordSet Resource")
model DnsNamespaceManagerAppendARecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendARecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
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
