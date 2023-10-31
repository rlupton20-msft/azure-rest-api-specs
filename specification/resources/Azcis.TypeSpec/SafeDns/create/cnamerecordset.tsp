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
@doc("DnsNamespaceManagerCNameRecordSet Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerCNameRecordSet properties")
model DnsNamespaceManagerCNameRecordSetResourceProperties {
  @doc("Gets or sets the canonical name in String format")
  cName: CNameRecord;

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Gets or sets the owning team's ServiceTree Id and Contact Email")
  recordSetOwner: RecordSetOwner;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerCNameRecordSet Resource")
model DnsNamespaceManagerCNameRecordSetResource
  is ProxyResource<DnsNamespaceManagerCNameRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerCNameRecordSet") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Interface types must use PascalCase"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerCNameRecordSets {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerCNameRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerCNameRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerCNameRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerCNameRecordSetResource>;
}
