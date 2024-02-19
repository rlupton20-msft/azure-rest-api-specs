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
@doc("DnsNamespaceManagerAppendTxtRecordSet Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

@doc("DnsNamespaceManagerAppendTxtRecordSet properties")
model DnsNamespaceManagerAppendTxtRecordSetResourceProperties {
  @doc("Gets or sets the TXT Records")
  txtRecord: TxtRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerAppendTxtRecordSet Resource")
model DnsNamespaceManagerAppendTxtRecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendTxtRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAppendTxtRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerAppendTxtRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerAppendTxtRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerAppendTxtRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerAppendTxtRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerAppendTxtRecordSetResource>;
}
