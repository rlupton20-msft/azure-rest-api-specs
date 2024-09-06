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

@doc("DnsNamespaceManagerAaaaRecordSet properties")
model DnsNamespaceManagerAaaaRecordSetResourceProperties {
  @doc("Gets or sets the AAAA Records")
  @extension("x-ms-identifiers", [])
  aaaaRecords: AaaaRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("Gets or sets the owning team's ServiceTree Id and Contact Email")
  recordSetOwner: RecordSetOwner;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerAaaaRecordSet Resource")
model DnsNamespaceManagerAaaaRecordSetResource
  is ProxyResource<DnsNamespaceManagerAaaaRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAaaaRecordSets") // start with lower case
  @visibility("read")
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
