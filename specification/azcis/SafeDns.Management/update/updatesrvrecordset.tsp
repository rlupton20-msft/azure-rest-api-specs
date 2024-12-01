import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("DnsNamespaceManagerUpdateSrvRecordSet properties")
model DnsNamespaceManagerUpdateSrvRecordSetResourceProperties {
  @doc("Gets or sets the SRV records")
  @extension("x-ms-identifiers", [])
  srvRecords: SrvRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerUpdateSrvRecordSet Resource")
model DnsNamespaceManagerUpdateSrvRecordSetResource
  is ProxyResource<DnsNamespaceManagerUpdateSrvRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateSrvRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerUpdateSrvRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerUpdateSrvRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerUpdateSrvRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerUpdateSrvRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerUpdateSrvRecordSetResource>;
}
