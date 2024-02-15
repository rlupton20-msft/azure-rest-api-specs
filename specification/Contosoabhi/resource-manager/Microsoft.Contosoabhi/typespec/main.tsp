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

@armProviderNamespace("Microsoft.Contosoabhi")
@service({
  title: "Microsoft.Contosoabhi",
  version: "2024-01-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Contosoabhi;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ContosoabhiProviderHub resource")
model Databaseabhi is TrackedResource<DatabaseabhiProperties> {
  @doc("The name of the databaseabhi")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DatabaseabhiName")
  @segment("Databaseabhis")
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

@doc("Details of the Contosoabhi Databaseabhi.")
model DatabaseabhiProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Databaseabhi)
interface Databaseabhis {
  get is ArmResourceRead<Databaseabhi>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Databaseabhi>;
  update is ArmResourcePatchSync<Databaseabhi, DatabaseabhiProperties>;
  delete is ArmResourceDeleteSync<Databaseabhi>;
  listByResourceGroup is ArmResourceListByParent<Databaseabhi>;
  listBySubscription is ArmListBySubscription<Databaseabhi>;
}
