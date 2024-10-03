import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SaaSHub;
/**
 * A SaaSHub cloud service.
 */
model SaasResource
  is Azure.ResourceManager.ProxyResource<SaasResourceProperties> {
  ...ResourceNameParameter<
    Resource = SaasResource,
    KeyName = "SaasResourceName",
    SegmentName = "saasResources",
    NamePattern = "^[-_0-9a-zA-Z]{3,50}$"
  >;
}

@armResourceOperations
interface SaasResources {
  /**
   * Gets a SaaSHub cloud service by its ID. The operation is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  get is ArmResourceRead<SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Creates or updates a SaaSHub cloud service.
   */
  create is ArmResourceCreateOrReplaceAsync<SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Updates the properties of a SaaSHub cloud service.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<SaasResource, SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Deletes a SaaSHub cloud service resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Lists the SaaSHub cloud services under the tenant.
   */
  listByTenant is ArmResourceListByParent<SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Evaluates whether an existing cloud service resource can be cancelled.
   */
  canCancel is ArmResourceActionSync<SaasResource, void, CanCancelResult, BaseParameters = ApiVersionParameter>;

  /**
   * Evaluates whether the source cloud service resource can be merged to target cloud service resource.
   */
  canMerge is ArmResourceActionSync<
    SaasResource,
    MergeSaasResourceRequest,
    CanMergeResult,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Evaluates whether the request payload can update an existing cloud service resource.
   */
  canUpdate is ArmResourceActionSync<
    SaasResource,
    SaasResource,
    CanUpdateResult,
    BaseParameters = ApiVersionParameter
  >;

  /**
   * Cancels a SaaSHub cloud service.
   */
  cancel is ArmResourceActionAsync<SaasResource, void, SaasResource, BaseParameters = ApiVersionParameter>;

  /**
   * Merges multiple cloud service resources into one target cloud service resource. The resource name in URL is the target, and the list of source cloud service resource and quantity will be specified in request payload
   */
  merge is ArmResourceActionAsync<
    SaasResource,
    MergeSaasResourceRequest,
    SaasResource,
    BaseParameters = ApiVersionParameter
  >;
}

@@maxLength(SaasResource.name, 50);
@@minLength(SaasResource.name, 3);
@@doc(SaasResource.name,
  "The name that uniquely identifies a SaaSHub cloud service."
);
@@doc(SaasResource.properties, "The properties of a SaaSHub cloud service.");
@@doc(SaasResources.create::parameters.resource,
  "Request parameters that are provided to the create SaaSHub cloud service operation."
);
@@doc(SaasResources.update::parameters.properties,
  "Request parameters that are provided to the update SaaSHub cloud service operation."
);
@@doc(SaasResources.canMerge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub cloud service operation."
);
@@doc(SaasResources.canUpdate::parameters.body,
  "Request parameters that are provided to the update SaaSHub cloud service operation."
);
@@doc(SaasResources.merge::parameters.body,
  "Request parameters that are provided to the merge SaaSHub cloud service operation."
);
