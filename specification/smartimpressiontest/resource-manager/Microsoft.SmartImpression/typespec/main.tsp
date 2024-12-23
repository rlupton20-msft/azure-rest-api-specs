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

@armProviderNamespace("Microsoft.SmartImpression")
@service({
  title: "Microsoft.SmartImpression",
  version: "2024-01-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.SmartImpression;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SmartImpressionProviderHub resource")
model SmartImpressionService is TrackedResource<SmartImpressionServiceProperties> {
  @doc("The name of the SmartImpressionService")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("SmartImpressionServiceName")
  @segment("SmartImpressionServices")
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

@doc("Details of the SmartImpression SmartImpressionService.")
model SmartImpressionServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(SmartImpressionService)
interface SmartImpressionServices {
  get is ArmResourceRead<SmartImpressionService>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SmartImpressionService>;
  update is ArmResourcePatchSync<SmartImpressionService, SmartImpressionServiceProperties>;
  delete is ArmResourceDeleteSync<SmartImpressionService>;
  listByResourceGroup is ArmResourceListByParent<SmartImpressionService>;
  listBySubscription is ArmListBySubscription<SmartImpressionService>;
}
