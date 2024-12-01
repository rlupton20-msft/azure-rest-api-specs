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

@armProviderNamespace("Microsoft.HermonBakery")
@service({
  title: "Microsoft.HermonBakery",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.HermonBakery;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A HermonBakeryProviderHub resource")
model Pastry is TrackedResource<PastryProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("PastryName")
  @segment("Pastrys")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Provisioning state")
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the HermonBakery Pastry.")
model PastryProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Pastrys extends TrackedResourceOperations<Pastry, PastryProperties> {}
