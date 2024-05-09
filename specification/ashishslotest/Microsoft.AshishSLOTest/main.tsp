import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AshishSLOTest")
@service({
  title: "Microsoft.AshishSLOTest",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AshishSLOTest;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AshishSLOTestProviderHub resource")
model sloMetadata is TrackedResource<SLOMetadataProperties> {
  @doc("The name of the SLO")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("sloMetadataName")
  @segment("sloMetadatas")
  @path
  name: string;
}

@doc("A AshishSLOTestProviderHub resource")
model slo is ExtensionResource<SLOMetadataProperties> {
  @doc("The name of the SLO")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("slos")
  @segment("slos")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the AshishSLOTest SLOMetadata.")
model SLOMetadataProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(sloMetadata)
interface sloMetadatas {
  get is ArmResourceRead<sloMetadata>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<sloMetadata>;
  update is ArmResourcePatchSync<sloMetadata, SLOMetadataProperties>;
  delete is ArmResourceDeleteSync<sloMetadata>;
  listByResourceGroup is ArmResourceListByParent<sloMetadata>;
  listBySubscription is ArmListBySubscription<sloMetadata>;
}

@armResourceOperations(slo)
interface slos {
  get is ArmResourceRead<slo>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<slo>;
  update is ArmResourcePatchSync<slo, SLOMetadataProperties>;
  delete is ArmResourceDeleteSync<slo>;
  listByResourceGroup is ArmResourceListByParent<slo>;
  listBySubscription is ArmListBySubscription<slo>;
}
