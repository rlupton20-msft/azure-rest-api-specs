import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models.tsp";
import "../Pipeline.tsp";
import "./FlowProfileModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Private.AzureDataTransfer;
/**
 * The FlowProfile resource definition.
 */
@parentResource(Pipeline)
model FlowProfile
  is Azure.ResourceManager.TrackedResource<FlowProfileProperties> {
  ...ResourceNameParameter<
    Resource = FlowProfile,
    KeyName = "flowProfileName",
    SegmentName = "flowprofiles",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

model ArmFlowProfileResponse is ArmResponse<FlowProfile>;

@armResourceOperations
interface FlowProfiles {
  /**
   * Gets FlowProfile resource.
   */
  get is ArmResourceRead<FlowProfile>;

  /**
   * Creates or updates the FlowProfile resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FlowProfile>;

  /**
   * Updates the FlowProfile resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Prior OpenAPI2 Json spec provides the resource back in the LRO response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    FlowProfile,
    PatchModel = FlowProfilePatch,
    Response = ArmResponse<FlowProfile> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: FlowProfile;
    })
  >;

  /**
   * Deletes the FlowProfile resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<FlowProfile>;

  /**
   * Get FlowProfiles in a pipeline
   */
  listByPipeline is ArmResourceListByParent<FlowProfile>;
}

@@maxLength(FlowProfile.name, 64);
@@minLength(FlowProfile.name, 3);
@@doc(FlowProfile.name, "The name for the FlowProfile to perform the operation on.");
@@doc(FlowProfile.properties, "Properties of FlowProfile");
@@doc(FlowProfiles.createOrUpdate::parameters.resource, "FlowProfile body");
@@doc(FlowProfiles.update::parameters.properties, "FlowProfile body");