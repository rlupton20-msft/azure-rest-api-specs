using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

using Azure.ResourceManager.Foundations;

namespace Private.OracleDatabaseDev;

// https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-operations#asynchronous-list-action
@armResourceOperations
interface InternalList {
  @doc("Generic Sync List operation")
  @autoRoute
  @segmentOf(TResource)
  @armResourceAction(TResource)
  @armResourceList(TResource)
  @action("ResourceReadBegin")
  @post
  ResourceReadBeginListSync<
    TResource extends Foundations.Resource,
    TRequest,
    TResponse,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceParentParameters<TResource, TBaseParameters>,
    ...Azure.Core.StandardListQueryParameters,

    @doc("Body of read begin list")
    @body
    body: {
      value: TRequest[];
    },
  ): ArmResponse<TResponse> | ErrorResponse;
}

@armResourceOperations
interface ListActions {
  @doc("Generic Async Get operation")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @autoRoute
  @armResourceAction(TResource)
  @post
  ArmResourceGetActionAsync<
    TResource extends Foundations.Resource,
    TResponse,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ): ArmResponse<TResponse> | ArmAcceptedLroResponse | ErrorResponse;

  @doc("Generic Sync List operation")
  @armResourceAction(TResource)
  @armResourceList(TResource)
  @get
  op ArmResourceGetAction<
    TResource extends Foundations.Resource,
    TResponse,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>
  ): ArmResponse<TResponse> | ErrorResponse;
}
