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
@doc("PtrRecord Provider")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

@doc("PtrRecord properties")
model PtrRecordResourceProperties {
  @doc("Gets or sets the dns name")
  dnsName: string;

  @doc("Gets or sets the IP Address in String format")
  pointsTo: string;

  @doc("Gets or sets the ttl")
  ttl: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: PtrRecordProvisioningState;
}

@doc("PtrRecord Resource")
model PtrRecordResource is ProxyResource<PtrRecordResourceProperties> {
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("ptrRecords") // start with lower case
  @visibility("read")
  @path
  name: string;
}

@doc("Provisioning status of the resource.")
enum PtrRecordProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PtrRecord {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PtrRecordResource>;
  listBySubscription is ArmListBySubscription<PtrRecordResource>;
  listByResourceGroup is ArmResourceListByParent<PtrRecordResource>;
  get is ArmResourceRead<PtrRecordResource>;
}
