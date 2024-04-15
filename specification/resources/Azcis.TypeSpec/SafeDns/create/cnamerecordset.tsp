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

namespace Microsoft.AzureCIS;

@doc("DnsNamespaceManagerCnameRecordSet properties")
model DnsNamespaceManagerCnameRecordSetResourceProperties {
  @doc("Gets or sets the canonical name in String format")
  cNameRecord: CNameRecord;

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

@doc("DnsNamespaceManagerCnameRecordSet Resource")
model DnsNamespaceManagerCnameRecordSetResource
  is ProxyResource<DnsNamespaceManagerCnameRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerCNameRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerCnameRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerCnameRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerCnameRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerCnameRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerCnameRecordSetResource>;
}
