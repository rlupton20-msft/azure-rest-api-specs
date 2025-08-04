import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("DnsNamespaceManagerSrvRecordSet properties")
model DnsNamespaceManagerSrvRecordSetResourceProperties {
  @doc("Gets or sets the SRV records")
  @Azure.ResourceManager.identifiers(#[])
  srvRecords: SrvRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Gets or sets the owning team's ServiceTree Id and Contact Email")
  recordSetOwner: RecordSetOwner;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerSrvRecordSet Resource")
model DnsNamespaceManagerSrvRecordSetResource
  is ProxyResource<DnsNamespaceManagerSrvRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerSrvRecordSets") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerSrvRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerSrvRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerSrvRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerSrvRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerSrvRecordSetResource>;
}
