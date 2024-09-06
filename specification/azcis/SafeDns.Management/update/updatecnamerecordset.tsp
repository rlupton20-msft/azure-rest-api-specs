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

namespace Microsoft.AzureCis;

@doc("DnsNamespaceManagerUpdateCnameRecordSet properties")
model DnsNamespaceManagerUpdateCnameRecordSetResourceProperties {
  @doc("Gets or sets the canonical name in String format")
  cNameRecord: CNameRecord;

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("The Azure location.")
  azureLocation?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerUpdateCnameRecordSet Resource")
model DnsNamespaceManagerUpdateCnameRecordSetResource
  is ProxyResource<DnsNamespaceManagerUpdateCnameRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateCNameRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerUpdateCnameRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerUpdateCnameRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerUpdateCnameRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerUpdateCnameRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerUpdateCnameRecordSetResource>;
}
