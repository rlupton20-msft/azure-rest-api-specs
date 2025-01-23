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

@armProviderNamespace("Private.IndustryPlatform")
@service({
  title: "Private.IndustryPlatform"
})

@versioned(Private.IndustryPlatform.Versions)
namespace Private.IndustryPlatform;

@doc("Supported API versions for the Private.IndustryPlatform resource provider.")
enum Versions {
  @doc("The 2024-10-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_10_01_preview: "2024-10-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A IndustryPlatformProviderHub resource")
model IndustryServicesResource is TrackedResource<IndustryServicesResourceProperties> {
  @doc("The name of the IndustryService Resource Name")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("industryServiceResourceName")
  @segment("industryServices")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
  ...ResourceSkuProperty;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  /** Resource has been created. */
  Succeeded:"Succeeded",
  /** Resource creation failed. */
  Failed:"Failed",
  /** Resource creation was canceled. */
  Canceled:"Canceled",
  /** The resource is being provisioned */
  Provisioning:"Provisioning",
  /** The resource is updating */
  Updating:"Updating",
  /** The resource is being deleted */
  Deleting:"Deleting",
  /** The resource create request has been accepted */
  Accepted:"Accepted"
}

@doc("Details of the IndustryPlatform IndustryServices.")
model IndustryServicesResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("IndustryService Resource Version.")
  version?: string;

  @visibility("read", "create")
  @doc("AAD Application Id.")
  @pattern("^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$")
  aadApplicationId: string;

  @visibility("read")
  @doc("Service Url")
  serviceUrl?: string;

  @visibility("read")
  @doc("Configuration of the managed resource group associated with the resource.")
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  @visibility("read")
  @doc("Managed On Behalf Of Configuration.")
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Deny Assignments exclusion list.")
  @visibility("read", "update")
  denyAssignmentExclusions?: DenyAssignmentExclusion[];
}

@doc("Configuration of the managed resource group associated with the resource.")
model ManagedResourceGroupConfiguration {
  @doc("The resource group name.")
  name: string;

  @doc("The resource group location.")
  location: string;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
    @visibility("read")
    @doc("Associated MoboBrokerResources.")
    moboBrokerResources: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  @visibility("read")
  id: string;
}


@doc("The properties related to Deny Assignment Exclusions")
model DenyAssignmentExclusion {
  @doc("Object Id of Identity")
  @visibility("read","update")
  id: string;

  @doc("Type of Identity")
  @visibility("read","update")
  type: string;
}

@armResourceOperations(IndustryServicesResource)
interface IndustryServices  {
  get is ArmResourceRead<IndustryServicesResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IndustryServicesResource>;
  //update is ArmResourcePatchAsync<IndustryServiceResource, IndustryServiceResourceProperties>;
  //temporary fix until typespec fix the issue of generating update classes
  update is ArmCustomPatchAsync<IndustryServicesResource, Azure.ResourceManager.Foundations.ResourceUpdateModel<IndustryServicesResource, IndustryServicesResourceProperties>>;
  delete is ArmResourceDeleteWithoutOkAsync<IndustryServicesResource>;
  listByResourceGroup is ArmResourceListByParent<IndustryServicesResource>;
  listBySubscription is ArmListBySubscription<IndustryServicesResource>;
}