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

@armProviderNamespace("Microsoft.HealthAI")
@service({
  title: "Microsoft.HealthAI",
  version: "2024-01-12-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.HealthAI;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A HealthAIProviderHub resource")
model ImageToReportAPI is TrackedResource<ImageToReportAPIProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ImageToReportAPIName")
  @segment("ImageToReportAPIs")
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

@doc("Details of the HealthAI ImageToReportAPI.")
model ImageToReportAPIProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations(ImageToReportAPI)
interface ImageToReportAPIs {
  get is ArmResourceRead<ImageToReportAPI>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ImageToReportAPI>;
  update is ArmResourcePatchSync<ImageToReportAPI, ImageToReportAPIProperties>;
  delete is ArmResourceDeleteSync<ImageToReportAPI>;
  listByResourceGroup is ArmResourceListByParent<ImageToReportAPI>;
  listBySubscription is ArmListBySubscription<ImageToReportAPI>;
}
