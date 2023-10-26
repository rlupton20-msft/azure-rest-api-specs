using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Private.IntegrationService;

// NOTE(archidda): This is a template for resource list actions that return synchronously with no request body. This which will be added to the library at some point.
#suppress "@azure-tools/typespec-azure-core/documentation-required" "This is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a template"
@armResourceAction(TResource)
@post
op ArmResourceListActionSync<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TResponse extends unknown,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>
): ArmResponse<TResponse> | ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a template"
/**
 * A synchronous resource action with no response body.
 * @template TResource The resource being acted upon
 * @template TRequest The request model for the action
 * @template TResponse The response model for the action
 * @template TBaseParameters Optional. Allows overriding the parameters for the operation
 */
@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceActionRawSync<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TRequest extends TypeSpec.Reflection.Model,
  TResponse extends TypeSpec.Reflection.Model,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The content of the action request")
  @body
  body: TRequest,
): TResponse | ErrorResponse;