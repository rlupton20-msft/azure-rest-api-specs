import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./SaasResourceModels.tsp";
import "@typespec/versioning";
import "./SharedModels.tsp";
import "./SaasResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.SaaSHub;

@armResourceOperations
interface ProviderLevelActions {
  /**
   * Evaluates whether the request payload can create a new SaaS resource.        
   * Only available in API versions 2024-09-30-preview and 2025-07-01-preview.    
   */
  @route("/providers/Microsoft.SaaSHub")
  @post
  @armResourceAction(Microsoft.SaaSHub.SaasResource)
  @added(Versions.v2024_09_30_preview)
  @added(Versions.v2025_07_01_preview)
  tenantLevelCanCreate(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the create SaaSHub SaaS resource operation.
     */
    @bodyRoot
    body: Microsoft.SaaSHub.CanCreateSaasResourceRequest,
  ): ArmResponse<Microsoft.SaaSHub.CanCreateResult> | ErrorResponse;
}
