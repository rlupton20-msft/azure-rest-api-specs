import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("DnsNamespaceManagerChildZoneDelegation properties")
model DnsNamespaceManagerChildZoneDelegationResourceProperties {
  @doc("Gets or sets the child DNS zone FQDN")
  childDnsZoneName: string;

  @doc("Gets or sets the ResourceGroupName hosting the child DNS zone")
  childDnsZoneResourceGroupName: string;

  @doc("Gets or sets the SubscriptionID hosting the Child DNS zone")
  childDnsZoneSubscriptionId: string;

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

@doc("DnsNamespaceManagerChildZoneDelegation Resource")
model DnsNamespaceManagerChildZoneDelegationResource
  is ProxyResource<DnsNamespaceManagerChildZoneDelegationResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("dnsNamespaceManagerChildZoneDelegations") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DnsNamespaceManagerChildZoneDelegation {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DnsNamespaceManagerChildZoneDelegationResource>;
  listBySubscription is ArmListBySubscription<DnsNamespaceManagerChildZoneDelegationResource>;
  listByResourceGroup is ArmResourceListByParent<DnsNamespaceManagerChildZoneDelegationResource>;
  get is ArmResourceRead<DnsNamespaceManagerChildZoneDelegationResource>;
}
