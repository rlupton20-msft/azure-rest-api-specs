import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./SaasResourceModels.tsp";
import "./CloudServiceModels.tsp";
import "@typespec/versioning";
import "./SharedModels.tsp";
import "./SaasResource.tsp";
import "./CloudService.tsp";
import "./versions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.SaaSHub;

@armResourceOperations
interface ProviderLevelActions {
  /**
   * Evaluates whether the request payload can create a new SaaS resource.
   * Not available in API versions 2023-01-01-preview.
   */
  @route("/providers/Microsoft.SaaSHub")
  @post
  @armResourceAction(Microsoft.SaaSHub.SaasResource)
  tenantLevelCanCreate(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the create SaaSHub SaaS resource operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CanCreateSaasResourceRequest,
  ): ArmResponse<Microsoft.SaaSHub.CanCreateResult> | ErrorResponse;

  /**
   * Evaluates whether the request payload can create a new cloud service resource.
   * Only available in API version 2025-07-01-preview.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SaaSHub")
  @post
  @armResourceAction(Microsoft.SaaSHub.CloudService)
  resourceGroupLevelCanCreate(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Request parameters that are provided to the create SaaSHub cloud service operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CanCreateCloudServiceRequest,
  ): ArmResponse<Microsoft.SaaSHub.CanCreateResult> | ErrorResponse;
}
