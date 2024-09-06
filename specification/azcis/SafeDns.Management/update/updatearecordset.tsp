import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerUpdateARecordSet properties")
model DnsNamespaceManagerUpdateARecordSetResourceProperties {
  @doc("Gets or sets the array of A Records")
  @extension("x-ms-identifiers", [])
  aRecords: ARecord[];

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

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
@doc("DnsNamespaceManagerUpdateARecordSet Resource")
model DnsNamespaceManagerUpdateARecordSetResource
  is ProxyResource<DnsNamespaceManagerUpdateARecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateARecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Interface types must use PascalCase"
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerUpdateARecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerUpdateARecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerUpdateARecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerUpdateARecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerUpdateARecordSetResource>;
}
