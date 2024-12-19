import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.StorageGateway")
@service({
  title: "Microsoft.StorageGateway",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.StorageGateway;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  `2021-08-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A StorageGatewayProviderHub resource")
model agent is TrackedResource<agentProperties> {
  @doc("The name of the agent")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agentName")
  @segment("agents")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
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

@doc("Details of the StorageGateway Agent.")
model agentProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(agent)
interface agents {
  get is ArmResourceRead<agent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<agent>;
  update is ArmResourcePatchSync<agent, agentProperties>;
  delete is ArmResourceDeleteSync<agent>;
  listByResourceGroup is ArmResourceListByParent<agent>;
  listBySubscription is ArmListBySubscription<agent>;
}
