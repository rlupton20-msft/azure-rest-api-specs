import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "../Private.EdgeInternal.Shared/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Private.EdgeInternal;
@doc("Disconnected operations image resource.")
@parentResource(DisconnectedOperation)
model Image is ProxyResource<ImageProperties> {
  ...ResourceNameParameter<Image>;
}

@armResourceOperations
interface Images {

  @doc("Get the resource")
  get is ArmResourceRead<Image>;

  @doc("get deployment manifest.")
  listDownloadUri is ArmResourceActionSync<
    Image,
    void,
    ArmResponse<ImageDownloadResult> | ErrorResponse
  >;

  @doc("List by parent")
  @added(Versions.v2025_05_01)
  listAll is ArmResourceListByParent<
    Image,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<Image> & {
      ...FilterQueryParameter;
      ...TopQueryParameter;
      ...SkipQueryParameter;
    }
  >;
}
