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
using OpenAPI;

namespace Microsoft.AzureMonitorEdge;

@doc("OpenTelemetry Collector Gateway resource")
model Gateway is TrackedResource<GatewayProperties> {
    @doc("Name of the instance of the OtelCollector")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("instanceName")
    @path
    @segment("gateways")
    name: string;

    // Extended location is not included in TrackedResource yet
    @doc("Edge location of the resource")
    @visibility("read","create")
    extendedLocation?: ExtendedLocation;
}

@doc("OtelCollector properties")
model GatewayProperties {
    @doc("Configuration of the OtelCollector")
    config: string,
    
    @visibility("read")
    @doc("Gets and sets the property provisioningState. The status of the last operation.")
    provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Gateways {
  get is ArmResourceRead<Gateway>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Gateway>;
  update is ArmResourcePatchSync<Gateway, GatewayProperties>;
  delete is ArmResourceDeleteSync<Gateway>;
  listByResourceGroup is ArmResourceListByParent<Gateway>;
  listBySubscription is ArmListBySubscription<Gateway>;
}
