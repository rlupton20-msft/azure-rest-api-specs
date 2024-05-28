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

@armProviderNamespace("Microsoft.SustainabilityServices")
@service({
  title: "Microsoft.SustainabilityServices"
})

@versioned(Microsoft.SustainabilityServices.Versions)
namespace Microsoft.SustainabilityServices;

@doc("Supported API versions for the Microsoft.SustainabilityServices resource provider.")
enum Versions {
  @doc("The 2024-10-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A SustainabilityServicesProviderHub resource")
model CalculationResource is TrackedResource<CalculationResourceProperties> {
  @doc("The name of the Calculation Resource Name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("calculationResourceName")
  @segment("calculations")
  @path
  name: string;

  ...ManagedServiceIdentity;
  ...ResourceSku;
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

@doc("Details of the SustainabilityServices Calculations.")
model CalculationResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;


  @doc("Calculation Resource Version.")
  @visibility("read", "create", "update")
  version?: string;
}

@armResourceOperations(CalculationResource)
interface Calculations  {
  get is ArmResourceRead<CalculationResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CalculationResource>;
  update is ArmResourcePatchAsync<CalculationResource, CalculationResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<CalculationResource>;
  listByResourceGroup is ArmResourceListByParent<CalculationResource>;
  listBySubscription is ArmListBySubscription<CalculationResource>;
}
