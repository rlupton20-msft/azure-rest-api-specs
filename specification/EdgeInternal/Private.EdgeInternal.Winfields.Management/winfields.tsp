import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Private.EdgeInternal;
@doc("An offer.")
model Winfield is TrackedResource<WinfieldProperties> {
  @doc("Name of the resource")
  @path
  @key("name")
  @segment("winfields")
  name: string;
}

@armResourceOperations
interface Winfields
  extends Azure.ResourceManager.TrackedResourceOperations<
      Winfield,
      WinfieldProperties
    > {
  get is ArmResourceRead<Winfield>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Winfield>;
  delete is ArmResourceDeleteWithoutOkAsync<Winfield>;
  @doc("get deployment manifest.")
  listDeploymentManifest is ArmResourceActionSync<
    Winfield,
    void,
    ArmResponse<WinfieldDeploymentManifest> | ErrorResponse
  >;
}
