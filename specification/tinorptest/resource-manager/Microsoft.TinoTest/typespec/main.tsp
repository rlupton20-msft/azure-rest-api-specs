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

@armProviderNamespace("Microsoft.TinoTest")
@service({
  title: "Microsoft.TinoTest",
  version: "2024-01-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.TinoTest;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A TinoTestProviderHub resource")
model Database is TrackedResource<DatabaseProperties> {
  @doc("The name of the database")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DatabaseName")
  @segment("Databases")
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

@doc("Details of the TinoTest Database.")
model DatabaseProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Database)
interface Databases {
  get is ArmResourceRead<Database>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Database>;
  update is ArmResourcePatchSync<Database, DatabaseProperties>;
  delete is ArmResourceDeleteSync<Database>;
  listByResourceGroup is ArmResourceListByParent<Database>;
  listBySubscription is ArmListBySubscription<Database>;
}
