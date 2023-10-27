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

@armProviderNamespace("Microsoft.PhoenixCommon")
@service({
  title: "Microsoft.PhoenixCommon",
  version: "2023-08-22-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.PhoenixCommon;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A MassDriver")
model MassDriver is TrackedResource<MassDriverProperties> {
  @doc("driver name")
  @key("massdriverName")
  @segment("massDrivers")
  @visibility("read")
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

@doc("The properties of MassDriver")
model MassDriverProperties {
  @doc("The user's full name")
  @visibility("read")
  fullName: string;

  @doc("MassDriver Type")
  massDriverType: int32;

  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface MassDrivers {
  get is ArmResourceRead<MassDriver>;
  create is ArmResourceCreateOrUpdateSync<MassDriver>;
  delete is ArmResourceDeleteSync<MassDriver>;
  update is ArmResourcePatchSync<MassDriver, MassDriverProperties>;
  listByParent is ArmResourceListByParent<MassDriver>;
  listBySubscription is ArmListBySubscription<MassDriver>;
}
