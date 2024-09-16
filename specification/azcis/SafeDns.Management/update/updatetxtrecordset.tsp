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

@doc("DnsNamespaceManagerUpdateTxtRecordSet properties")
model DnsNamespaceManagerUpdateTxtRecordSetResourceProperties {
  @doc("Gets or sets the TXT Records")
  @extension("x-ms-identifiers", [])
  txtRecords: TxtRecord[];

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

@doc("DnsNamespaceManagerUpdateTxtRecordSet Resource")
model DnsNamespaceManagerUpdateTxtRecordSetResource
  is ProxyResource<DnsNamespaceManagerUpdateTxtRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateTxtRecordSets") // start with lower case
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerUpdateTxtRecordSet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerUpdateTxtRecordSetResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerUpdateTxtRecordSetResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerUpdateTxtRecordSetResource>;
  get is ArmResourceRead<DnsNamespaceManagerUpdateTxtRecordSetResource>;
}
