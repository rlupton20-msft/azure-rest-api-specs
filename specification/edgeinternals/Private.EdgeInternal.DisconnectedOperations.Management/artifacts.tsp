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
@doc("Disconnected operations artifact resource.")
@parentResource(Image)
@added(Versions.v2025_05_01)
model Artifact is ProxyResource<ArtifactProperties> {
  ...ResourceNameParameter<Artifact>;
}

@armResourceOperations
@added(Versions.v2025_05_01)
interface Artifacts {
  @doc("List by parent")
  listByParent is ArmResourceListByParent<Artifact>;

  @doc("Get the resource")
  get is ArmResourceRead<Artifact>;

  @doc("get artifact download link.")
  listDownloadUri is ArmResourceActionSync<
    Artifact,
    void,
    ArmResponse<ArtifactDownloadResult> | ErrorResponse
  >;
}
