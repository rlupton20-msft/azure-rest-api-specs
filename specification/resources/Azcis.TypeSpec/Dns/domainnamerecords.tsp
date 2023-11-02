import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
  version: "2023-08-22-preview",
})
@doc("DomainNameRecords Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

@doc("DomainNameRecords properties")
model DomainNameRecordsResourceProperties {
  @doc("List of all DNS records")
  dnsRecords: Array<DomainNameRecord>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DomainNameRecordsProvisioningState;
}

@doc("DomainNameRecords Resource")
model DomainNameRecordsResource
  is ProxyResource<DomainNameRecordsResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("domainNameRecordss") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("DomainNameRecord type model")
model DomainNameRecord {
  @doc("Gets or sets the domain name")
  name: string;

  @doc("Gets or sets the DNS TTL")
  ttl: string;

  @doc("Gets or sets the owning team's ServiceTree Id")
  serviceTreeId: string;
}

@doc("Provisioning status of the resource.")
enum DomainNameRecordsProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface DomainNameRecordss {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DomainNameRecordsResource>;
  listBySubscription is ArmListBySubscription<DomainNameRecordsResource>;
  listByResourceGroup is ArmResourceListByParent<DomainNameRecordsResource>;
  get is ArmResourceRead<DomainNameRecordsResource>;
}
