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

@armProviderNamespace("Microsoft.AIOpsCloudHealth")
@service({
  title: "Microsoft.AIOpsCloudHealth",
  version: "2023-05-11-privatepreview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AIOpsCloudHealth;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AIOpsCloudHealth.ProviderHub resource")
model EntityStateRule is TrackedResource<EntityStateRuleProperties> {
  @doc("The name of the EntityStateRule")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("entityStateRuleName")
  @segment("entityStateRules")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the AIOpsCloudHealth EntityStateRule.")
model EntityStateRuleProperties {
  @visibility("read")
  @doc("The provisioning state of the Entity State Rule.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface EntityStateRules extends TrackedResourceOperations<EntityStateRule, EntityStateRuleProperties> {}
