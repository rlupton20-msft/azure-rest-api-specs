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

@armProviderNamespace("Microsoft.DarmTest")
@service({
  title: "Microsoft.DarmTest",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.DarmTest;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A DarmTestProviderHub resource")
model DarmTestResource is TrackedResource<DarmTestResourceProperties> {
  @doc("The name of the darm resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("DarmTestResourceName")
  @segment("DarmTestResources")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Provisioning")
  Provisioning,
  @doc("Updating")
  Updating,
  @doc("Deleting")
  Deleting,
  @doc("Accepted")
  Accepted,
}

@doc("Details of the DarmTest DarmTestResource.")
model DarmTestResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface DarmTestResources extends TrackedResourceOperations<DarmTestResource, DarmTestResourceProperties> {}
