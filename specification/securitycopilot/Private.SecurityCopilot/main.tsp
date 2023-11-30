import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "SecurityCopilotClient",
  version: "2023-11-27-preview",
})
@doc("SecurityCopilot Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.SecurityCopilot;

@doc("A Security Copilot Unit resource")
model SecurityCopilotUnit is TrackedResource<SecurityCopilotUnitProperties> {
  @doc("Name of capacity unit")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  @key("name")
  @path
  @segment("scu")
  name: string;
}

@doc("Security Copilots Unit properties")
model SecurityCopilotUnitProperties {
  @doc("No of Units")
  @minValue(1)
  noOfUnits?: int64;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Location of Capacity Unit")
  @visibility("read")
  capacityLocation: string;

  @doc("Name of the workspace")
  @pattern("^[a-zA-Z0-9-]{3,63}$")
  workspace: string;
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SecurityCopilotUnits {
  get is ArmResourceRead<SecurityCopilotUnit>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SecurityCopilotUnit>;
  update is ArmResourcePatchSync<
    SecurityCopilotUnit,
    SecurityCopilotUnitProperties
  >;
  delete is ArmResourceDeleteSync<SecurityCopilotUnit>;
  listByResourceGroup is ArmResourceListByParent<SecurityCopilotUnit>;
  listBySubscription is ArmListBySubscription<SecurityCopilotUnit>;
  checkGlobalNameAvailability is checkGlobalNameAvailability;
}
