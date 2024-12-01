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

@armProviderNamespace("Private.MyTravels")
@service({
  title: "Private.MyTravels",
  version: "2021-10-01-privatepreview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.MyTravels;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A MyTravelsProviderHub resource")
model BusinessTravel is TrackedResource<BusinessTravelProperties> {
  @doc("The name of the business travel")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("BusinessTravelName")
  @segment("BusinessTravels")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}

@doc("Details of the MyTravels BusinessTravel.")
model BusinessTravelProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface BusinessTravels extends TrackedResourceOperations<BusinessTravel, BusinessTravelProperties> {}
