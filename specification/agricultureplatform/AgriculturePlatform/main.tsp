import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.AgriculturePlatform")
@service({
  title: "Microsoft.AgriculturePlatform"
})

@versioned(Microsoft.AgriculturePlatform.Versions)
namespace Microsoft.AgriculturePlatform;

@doc("Supported API versions for the Microsoft.AgriculturePlatform resource provider.")
enum Versions {
  @doc("The 2024-05-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AgriculturePlatform resource")
model AgriServiceResource is TrackedResource<AgriServiceResourceProperties> {
  @doc("The name of the AgriService resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agriServiceResourceName")
  @segment("agriService")
  @visibility("read")
  @path
  name: string;

  @doc("System data pertaining to the resource")
  @visibility("read")
  systemData?: AgriServiceResourceSystemData;
  ...ManagedServiceIdentity;
  ...TagsUpdateModel<AgriServiceResource>;
  ...ResourceSku;
}

@doc("System metadata pertaining to the AgriService resource.")
model AgriServiceResourceSystemData {
	...SystemData;
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

@doc("Details of the Agriculture AgriDataManager.")
model AgriServiceResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("AgriService resource version.")
  @visibility("read", "create", "update")
  version?: string;

  @visibility("read")
  @doc("Uri of the AgriService instance.")
  instanceUri?: string;
}

@armResourceOperations(AgriServiceResource)
interface AgriService  {
  get is ArmResourceRead<AgriServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgriServiceResource>;
  update is ArmResourcePatchAsync<AgriServiceResource, AgriServiceResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AgriServiceResource>;
  listByResourceGroup is ArmResourceListByParent<AgriServiceResource>;
  listBySubscription is ArmListBySubscription<AgriServiceResource>;
}