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

#suppress "@azure-tools/typespec-azure-core/casing-style" "Using the AI acronym similar to what was done for OpenAI"
@armProviderNamespace("Microsoft.HealthDataAIServices")
@service({
  title: "Microsoft.HealthDataAIServices",
  version: "2024-01-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.HealthDataAIServices;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
#suppress "@azure-tools/typespec-azure-core/casing-style" "Case-sensitive name"
@doc("A HealthDataAIServicesProviderHub resource")
model DeidService is TrackedResource<DeidServiceProperties> {
  @doc("The name of the deid service")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DeidServiceName")
  @segment("DeidServices")
  @path
  name: string;
}

@Azure.Core.lroStatus
@doc("The status of the current operation.")
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is provisioning")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is deleting")
  Deleting,

  @doc("The resource is accepted")
  Accepted,
}

@doc("Details of the HealthDataAIServices DeidService.")
model DeidServiceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("Deid service url.")
  serviceUrl?: string;

  ...ManagedSystemAssignedIdentity;
}

@armResourceOperations
interface DeidServices {
  get is ArmResourceRead<DeidService>;
  create is ArmResourceCreateOrUpdateSync<DeidService>;
  update is ArmResourcePatchSync<DeidService, DeidServiceProperties>;
  delete is ArmResourceDeleteSync<DeidService>;
  listByResourceGroup is ArmResourceListByParent<DeidService>;
  listBySubscription is ArmListBySubscription<DeidService>;
}
