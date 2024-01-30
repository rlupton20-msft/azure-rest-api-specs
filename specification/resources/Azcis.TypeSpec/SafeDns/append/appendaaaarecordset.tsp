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
@doc("DnsNamespaceManagerAppendAaaaRecordSet Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

@doc("DnsNamespaceManagerAppendAaaaRecordSet properties")
model DnsNamespaceManagerAppendAaaaRecordSetResourceProperties {
  @doc("Gets or sets the AAAA Records")
  aaaaRecords: AaaaRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerAppendAaaaRecordSet Resource")
model DnsNamespaceManagerAppendAaaaRecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendAaaaRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAppendAaaaRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerAppendAaaaRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerAppendAaaaRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerAppendAaaaRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerAppendAaaaRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerAppendAaaaRecordSetResource>;
}
