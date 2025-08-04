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

@doc("DnsNamespaceManagerAppendTxtRecordSet properties")
model DnsNamespaceManagerAppendTxtRecordSetResourceProperties {
  @doc("Gets or sets the TXT Records")
  @Azure.ResourceManager.identifiers(#[])
  txtRecords: TxtRecord[];

  @doc("Gets or sets the record set name (relative to the parent DNS zone that is hosting it).")
  relativeRecordSetName: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerAppendTxtRecordSet Resource")
model DnsNamespaceManagerAppendTxtRecordSetResource
  is ProxyResource<DnsNamespaceManagerAppendTxtRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerAppendTxtRecordSets") // start with lower case
  @visibility(Lifecycle.Read)
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
