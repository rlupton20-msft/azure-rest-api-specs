import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.SloTest")
@service({
  title: "Microsoft.SloTest",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SloTest;

@doc("The available API versions.")
enum Versions {
  @doc("The 2021-08-01-preview API version.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2021_08_01_preview: "2021-08-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SloTestProviderHub resource")
model Slo is ExtensionResource<SloProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("sloName")
  @segment("slos")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

@doc("Details of the SloTest Slo.")
model SloProperties {
  @doc("Slo Display Name")
  displayName: string;

  @doc("Slo Category")
  sloCategory: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Slo)
interface Slos {
  get is ArmResourceRead<Slo>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Slo>;
  update is ArmResourcePatchSync<Slo, SloProperties>;
  delete is ArmResourceDeleteSync<Slo>;
  listByResourceGroup is ArmResourceListByParent<Slo>;
}
