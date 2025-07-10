import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("CanonicalNameRecord properties")
model CanonicalNameRecordResourceProperties {
  @doc("Gets or sets the DNS name")
  dnsName: string;

  @doc("Gets or sets the canonical name")
  canonicalName: string;

  @doc("Gets or sets the TTL")
  ttl: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: CanonicalNameRecordProvisioningState;
}

@doc("CanonicalNameRecord Resource")
model CanonicalNameRecordResource
  is ProxyResource<CanonicalNameRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("canonicalNameRecords") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
union CanonicalNameRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface CanonicalNameRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CanonicalNameRecordResource>;
  listBySubscription is ArmListBySubscription<CanonicalNameRecordResource>;
  listByResourceGroup is ArmResourceListByParent<CanonicalNameRecordResource>;
  get is ArmResourceRead<CanonicalNameRecordResource>;
}
