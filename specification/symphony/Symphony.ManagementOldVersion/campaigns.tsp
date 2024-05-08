import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.Symphony;

@doc("The properties of the service.")
model CampaignProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The firstStage of the CampaignVersion.")
  firstStage?: string;

  @doc("The selfDriving of the CampaignVersion.")
  selfDriving?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The stages of the CampaignVersion.")
  stages?: Record<StageProperties>;
}

@doc("The service entity.")
model Campaign is TrackedResource<CampaignProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("campaignName")
  @segment("campaigns")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Campaigns {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<Campaign>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<Campaign>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<Campaign>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<Campaign>;
  @doc("Returns a collection of services within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Campaign>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Campaign>;
}
