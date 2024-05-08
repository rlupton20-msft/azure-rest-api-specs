import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Elements")
@service({
  title: "Microsoft.Elements",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@versioned(Versions)
namespace Microsoft.Elements;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A ElementsProviderHub resource")
model Workspace is TrackedResource<WorkspaceProperties> {
  @doc("The name of the workspace")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("workspaceName")
  @segment("workspaces")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",

  @doc("Operation Succeeded")
  Succeeded: "Succeeded",

  @doc("Operation failed")
  Failed: "Failed",

  @doc("Operation canceled")
  Canceled: "Canceled",
}

@doc("Details of the Elements Workspace.")
model WorkspaceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(Workspace)
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;
  update is ArmResourcePatchSync<Workspace, WorkspaceProperties>;
  delete is ArmResourceDeleteSync<Workspace>;
  listByResourceGroup is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}

@doc("Azure Large Instance api versions.")
enum Versions {
  @doc("Azure Large Instance api version 2023-07-20-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_07_20_preview: "2023-07-20-preview",
}
