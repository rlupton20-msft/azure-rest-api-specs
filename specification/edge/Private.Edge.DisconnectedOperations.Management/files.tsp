import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./disconnectedOperations.tsp";
import "../Microsoft.Edge.Shared/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;
@doc("Disconnected operations file resource.")
@parentResource(Image)
model File is ProxyResource<FileProperties> {
  ...ResourceNameParameter<File>;
}

@armResourceOperations
interface Files {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<
    File,
    {
      ...ApiVersionParameter;
      ...FilterQueryParameter;
      ...TopQueryParameter;
      ...SkipQueryParameter;
    }
  >;

  @doc("Get the resource")
  get is ArmResourceRead<File>;

  @doc("get file download link.")
  listDownloadUri is ArmResourceActionSync<
    Image,
    void,
    ArmResponse<FileDownloadResponse> | ErrorResponse
  >;
}
