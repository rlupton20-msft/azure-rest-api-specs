import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.PhoenixMassDriver")
@service({
  title: "Microsoft.PhoenixMassDriver",
})
@versioned(Versions)
namespace Microsoft.PhoenixMassDriver;

@doc("API Versions")
enum Versions {
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-08-22-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A MassDriver")
model MassDriver is TrackedResource<MassDriverProperties> {
  @doc("driver name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("massdriverName")
  @segment("massDrivers")
  @visibility("read")
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

  string,
}

@doc("The properties of MassDriver")
model MassDriverProperties {
  @doc("The user's full name")
  @visibility("read")
  fullName: string;

  @visibility("read")
  @doc("MassDriver Type")
  massDriverType: int32;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface MassDrivers {
  get is ArmResourceRead<MassDriver>;
  create is ArmResourceCreateOrReplaceSync<MassDriver>;
  delete is ArmResourceDeleteSync<MassDriver>;
  update is ArmResourcePatchSync<MassDriver, MassDriverProperties>;
  listByParent is ArmResourceListByParent<MassDriver>;
  listBySubscription is ArmListBySubscription<MassDriver>;
}
