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

@armProviderNamespace("Private.Learning")
@service({
  title: "Private.Learning",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.Learning;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A LearningProviderHub resource")
model CommunityTraining is TrackedResource<CommunityTrainingProperties> {
  @doc("The name of the Community Training Resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("CommunityTrainingName")
  @segment("CommunityTrainings")
  @path
  name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Resource is being provisioned")
  Provisioning,
  @doc("Resource is being deleted")
  Deleting,
}

@doc("Details of the Learning CommunityTraining.")
model CommunityTrainingProperties {
  @visibility("read,create")
  @doc("The website name of the CT instance.")
  websiteName: string;

  @visibility("read,create")
  @doc("The number of the website admin")
  websiteAdmin: string;

  @visibility("read,create")
  @doc("The contact email address of the CT resource")
  contactEmailAddress: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface CommunityTrainings extends TrackedResourceOperations<CommunityTraining, CommunityTrainingProperties> {}
