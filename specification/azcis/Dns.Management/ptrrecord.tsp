import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("Pointer record properties")
model PtrRecordResourceProperties {
  @doc("Gets or sets the DNS name")
  dnsName: string;

  @doc("Gets or sets the IP Address in String format")
  pointsTo: string;

  @doc("Gets or sets the TTL")
  ttl: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: PtrRecordProvisioningState;
}

@doc("Pointer record resource")
model PtrRecordResource is ProxyResource<PtrRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("pointerRecords") // start with lower case
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
union PtrRecordProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PtrRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PtrRecordResource>;
  listBySubscription is ArmListBySubscription<PtrRecordResource>;
  listByResourceGroup is ArmResourceListByParent<PtrRecordResource>;
  get is ArmResourceRead<PtrRecordResource>;
}
