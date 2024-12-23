import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "RP operations defined under quantum"
@armProviderNamespace("Microsoft.Quantum")
@service({
  title: "Microsoft.Quantum",
  version: "2023-04-17-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.Quantum;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A QuantumProviderHub resource")
model ElementsWorkspace is TrackedResource<ElementsWorkspaceProperties> {
  @doc("The name of the Elements Workspace.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("workspaceName")
  @segment("elementsWorkspaces")
  @path
  name: string;

  ...ManagedSystemAssignedIdentity;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Operation's status is provisioning.")
  Provisioning,

  @doc("Operation's status is updating.")
  Updating,

  @doc("Operation's status is deleting.")
  Deleting,

  @doc("Operation's status is accepted.")
  Accepted,
}

@doc("Details of the Quantum Elements Workspace.")
model ElementsWorkspaceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ElementsWorkspaces {
  get is ArmResourceRead<ElementsWorkspace>;
  create is ArmResourceCreateOrUpdateAsync<ElementsWorkspace>;
  update is ArmResourcePatchSync<
    ElementsWorkspace,
    ElementsWorkspaceProperties
  >;
  delete is ArmResourceDeleteAsync<ElementsWorkspace>;
  listByResourceGroup is ArmResourceListByParent<ElementsWorkspace>;
  listBySubscription is ArmListBySubscription<ElementsWorkspace>;
}
