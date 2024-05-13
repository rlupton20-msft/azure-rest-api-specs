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

@armProviderNamespace("Microsoft.Agriculture")
@service({
  title: "Microsoft.Agriculture"
})

@versioned(Microsoft.Agriculture.Versions)
namespace Microsoft.Agriculture;

@doc("Supported API versions for the Microsoft.Agriculture resource provider.")
enum Versions {
  @doc("The 2024-05-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AgricultureProviderHub resource")
model AgriDataManagerResource is TrackedResource<AgriDataManagerResourceProperties> {
  @doc("The name of the AgriDataManager Resource Name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agriDataManagerResourceName")
  @segment("agriDataManager")
  @visibility("read")
  @path
  name: string;

  @doc("System data pertaining to the resource")
  @visibility("read")
  systemData: AgriDataManagerResourceSystemData;
  ...ManagedServiceIdentity;
  ...TagsUpdateModel<AgriDataManagerResource>;
}

@doc("System metadata pertaining to the Agri data manager resource.")
model AgriDataManagerResourceSystemData {
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
model AgriDataManagerResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("AgriDataManager Resource Version.")
  @visibility("read", "create", "update")
  version?: string;

  @doc("Uri of the Data Manager For Agriculture instance.")
  @visibility("read")
  instanceUri: string;
}

@armResourceOperations(AgriDataManagerResource)
interface AgriDataManager  {
  get is ArmResourceRead<AgriDataManagerResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgriDataManagerResource>;
  update is ArmResourcePatchAsync<AgriDataManagerResource, AgriDataManagerResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AgriDataManagerResource>;
  listByResourceGroup is ArmResourceListByParent<AgriDataManagerResource>;
  listBySubscription is ArmListBySubscription<AgriDataManagerResource>;
}