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

@armProviderNamespace("Microsoft.TelecomsIMS")
@service({
  title: "Microsoft.TelecomsIms",
  version: "2023-06-15-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.TelecomsIms;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A TelecomsIMSProviderHub resource")
model ImsCoreSite is TrackedResource<ImsCoreSiteProperties> {
  @doc("The name of the IMS core site")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("IMSCoreSiteName")
  @segment("IMSCoreSites")
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

@doc("Details of the TelecomsIMS IMSCoreSite.")
model ImsCoreSiteProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ImsCoreSites extends TrackedResourceOperations<ImsCoreSite, ImsCoreSiteProperties> {}


#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A TelecomsIMSProviderHub resource")
@parentResource(ImsCoreSite)
model Scscf is TrackedResource<ScscfProperties> {
  @doc("The name of the S-CSCF")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("SCSCFName")
  @segment("SCSCFs")
  @path
  name: string;
}

@doc("Details of the TelecomsIMS S-CSCF.")
model ScscfProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
  @doc("The maximum expires= parameter that will be set on Contact headers at registrations, and therefore the amount of time before a UE has to re-register.")
  @minValue(60)
  @maxValue(2147483)
  regMaxExpires?: int32;
}

@armResourceOperations
interface Scscfs extends TrackedResourceOperations<Scscf, ScscfProperties> {}