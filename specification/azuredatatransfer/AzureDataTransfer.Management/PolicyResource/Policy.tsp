import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models.tsp";
import "../Pipeline.tsp";
import "./PolicyModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AzureDataTransfer;
/**
 * The policy resource definition.
 */
@parentResource(Pipeline)
model Policy
  is Azure.ResourceManager.TrackedResource<PolicyProperties> {
  ...ResourceNameParameter<
    Resource = Policy,
    KeyName = "policyName",
    SegmentName = "policies",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

model ArmPolicyResponse is ArmResponse<Policy>;

@armResourceOperations
interface Policies {
  /**
   * Gets policy resource.
   */
  get is ArmResourceRead<Policy>;

  /**
   * Creates or updates the policy resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Policy>;

  /**
   * Updates the policy resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Prior OpenAPI2 Json spec provides the resource back in the LRO response."
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Policy,
    PatchModel = PolicyPatch,
    Response = ArmResponse<Policy> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Policy;
    })
  >;

  /**
   * Deletes the policy resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Policy>;

  /**
   * Get Policies in a pipeline
   */
  listByPipeline is ArmResourceListByParent<Policy>;
}