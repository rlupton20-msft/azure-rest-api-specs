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

@doc("DnsNamespaceManagerAaaaRecordSet properties")
model DnsNamespaceManagerAaaaRecordSetResourceProperties {
  @doc("Gets or sets the AAAA Records")
  @Azure.ResourceManager.identifiers(#[])
  aaaaRecords: AaaaRecord[];

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

@doc("DnsNamespaceManagerAaaaRecordSet Resource")
model DnsNamespaceManagerAaaaRecordSetResource
  is ProxyResource<DnsNamespaceManagerAaaaRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAaaaRecordSets") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerAaaaRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerAaaaRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerAaaaRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerAaaaRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerAaaaRecordSetResource>;
}
