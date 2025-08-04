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

@doc("DnsNamespaceManagerUpdateTxtRecordSet properties")
model DnsNamespaceManagerUpdateTxtRecordSetResourceProperties {
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

@doc("DnsNamespaceManagerUpdateTxtRecordSet Resource")
model DnsNamespaceManagerUpdateTxtRecordSetResource
  is ProxyResource<DnsNamespaceManagerUpdateTxtRecordSetResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateTxtRecordSets") // start with lower case
  @visibility(Lifecycle.Read)
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
