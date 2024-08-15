import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Private;
using OpenAPI;

namespace Microsoft.Monitor;

@doc("An Azure Monitor Edge Gateway definition")
model Gateway is TrackedResource<GatewayProperties> {
    @doc("The name of the Azure Monitor Edge Gateway.  The name is case insensitive")
    @pattern("^(?!-)[a-zA-Z0-9-]+[^-]$")
    @key("gatewayName")
    @path
    @segment("gateways")
    name: string;
}

@doc("Properties that need to be specified to create a new gateway")
model GatewayProperties {
    @doc("Gateway configuration")
    config: string,

    @doc("The provisioning state of the Azure Monitor Edge Gateway. Set to Succeeded if everything is healthy.")
    @visibility("read")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Gateways {
  @doc("Returns the specific Azure Monitor workspace")
  get is ArmResourceRead<Gateway>;
  @doc("Create or update a workspace")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Gateway>;
  @doc("Updates part of a workspace")
  update is ArmResourcePatchSync<Gateway, GatewayProperties>;
  @doc("Delete a workspace")
  delete is ArmResourceDeleteSync<Gateway>;
  @doc("Lists all workspaces in the specified resource group")
  listByResourceGroup is ArmResourceListByParent<Gateway>;
  @doc("Lists all workspaces in the specified subscription")
  listBySubscription is ArmListBySubscription<Gateway>;
}
