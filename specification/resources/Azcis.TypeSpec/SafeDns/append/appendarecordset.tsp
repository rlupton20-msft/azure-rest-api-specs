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
@doc("DnsNamespaceManagerAppendArecordSet Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

@doc("DnsNamespaceManagerAppendArecordSet properties")
model DnsNamespaceManagerAppendArecordSetResourceProperties {
  @doc("Gets or sets the A Records")
  aRecords: Array<Arecord>;

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

@doc("DnsNamespaceManagerAppendArecordSet Resource")
model DnsNamespaceManagerAppendArecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendArecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAppendArecordSet") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerAppendArecordSets {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerAppendArecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerAppendArecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerAppendArecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerAppendArecordSetResource>;
}