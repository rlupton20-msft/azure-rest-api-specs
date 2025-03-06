import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop OneLake connector resource.")
@resource("onelakeconnectors")
model OneLakeConnector is TrackedResource<OneLakeConnectorProperties> {
  @doc("The name of the OneLake connector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("oneLakeConnectorName")
  @segment("onelakeconnectors")
  @path
  name: string;
}

@doc("OneLakeConnector properties")
model OneLakeConnectorProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("Resource ID of the hub resource to associate the one lake connector to.")
  hubResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hubs";
    }
  ]>;

  @doc("Host of the Microsoft Fabric in the form of https://<host>.fabric.microsoft.com.")
  @pattern(".+\\.fabric\\.microsoft\\.com")
  host?: string;

  @doc("GUID of the lakehouse to connect to.")
  lakehouseId: string;

  @doc("GUID of the workspace to connect to.")
  workspaceId: string;
}

@armResourceOperations
interface OneLakeConnectors {
  get is ArmResourceRead<OneLakeConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<OneLakeConnector>;
  update is ArmResourcePatchAsync<OneLakeConnector, OneLakeConnectorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<OneLakeConnector>;
  listByResourceGroup is ArmResourceListByParent<OneLakeConnector>;
  listBySubscription is ArmListBySubscription<OneLakeConnector>;
}
