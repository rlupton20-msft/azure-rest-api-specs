import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("DnsNamespaceManagerUpdateDelegation properties")
model DnsNamespaceManagerUpdateDelegationResourceProperties {
  @doc("Gets or sets the child DNS zone FQDN")
  childDnsZoneName: string;

  @doc("Gets or sets the ResourceGroupName hosting the child DNS zone")
  childDnsZoneResourceGroupName: string;

  @doc("Gets or sets the SubscriptionID hosting the Child DNS zone")
  childDnsZoneSubscriptionId: string;

  @doc("Gets or sets the domain name")
  dnsZoneName: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: DnsNamespaceManagerProvisioningState;
}

@doc("DnsNamespaceManagerUpdateDelegation Resource")
model DnsNamespaceManagerUpdateDelegationResource
  is ProxyResource<DnsNamespaceManagerUpdateDelegationResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerUpdateDelegations") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerUpdateDelegation {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerUpdateDelegationResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerUpdateDelegationResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerUpdateDelegationResource>;
  get is ArmResourceRead<DnsNamespaceManagerUpdateDelegationResource>;
}
