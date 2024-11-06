import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Private.EdgeInternal;
@doc("DisconnectedOperationsAppliance resource.")
model DisconnectedOperationsAppliance
  is TrackedResource<DisconnectedOperationsApplianceProperties> {
  @doc("Name of the resource")
  @path
  @key("name")
  @segment("disconnectedoperationsappliances")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  name: string;
}

@armResourceOperations
interface DisconnectedOperationsAppliances
  extends Azure.ResourceManager.TrackedResourceOperations<
      DisconnectedOperationsAppliance,
      DisconnectedOperationsApplianceProperties
    > {
  get is ArmResourceRead<DisconnectedOperationsAppliance>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DisconnectedOperationsAppliance>;
  delete is ArmResourceDeleteWithoutOkAsync<DisconnectedOperationsAppliance>;
  @doc("get deployment manifest.")
  listDeploymentManifest is ArmResourceActionSync<
    DisconnectedOperationsAppliance,
    void,
    ArmResponse<DisconnectedOperationsApplianceDeploymentManifest> | ErrorResponse
  >;
}
