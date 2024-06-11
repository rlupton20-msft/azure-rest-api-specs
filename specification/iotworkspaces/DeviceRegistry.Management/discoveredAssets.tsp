import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.DeviceRegistry;

@doc("Discovered Asset definition.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredAsset is TrackedResource<DiscoveredAssetProperties> {
  @doc("Discovered Asset name parameter.")
  @key("discoveredAssetName")
  @segment("discoveredAssets")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Defines the discovered asset properties.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredAssetProperties {
  @doc("Resource path to asset type (model) definition.")
  assetType?: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides data points for this asset. Must have the format <ModuleCR.metadata.namespace>/<ModuleCR.metadata.name>.")
  @visibility("read", "create")
  assetEndpointProfileUri: string;

  @doc("Unique identifier used to detect changes in the discovered asset.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int32;

  @doc("Discovered asset manufacturer name.")
  manufacturer?: string;

  @doc("Discovered asset manufacturer URI.")
  manufacturerUri?: string;

  @doc("Discovered asset model name.")
  // `model` is a reserved keyname. Wrap in double quotes
  `model`?: string;

  @doc("Discovered asset product code.")
  productCode?: string;

  @doc("Revision number of the hardware.")
  hardwareRevision?: string;

  @doc("Revision number of the software.")
  softwareRevision?: string;

  @doc("Reference to the documentation.")
  documentationUri?: string;

  @doc("Discovered asset serial number.")
  serialNumber?: string;

  @doc("Array of data points that are part of the discovered asset. Each data point can reference an asset type capability and have per-data point configuration. See below for more details for the definition of the dataPoints element.")
  @extension("x-ms-identifiers", [])
  dataPoints?: DiscoveredDataPoint[];

  @doc("Array of events that are part of the discovered asset. Each event can reference an asset type capability and have per-event configuration. See below for more details about the definition of the events element.")
  @extension("x-ms-identifiers", [])
  events?: DiscoveredEvent[];

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines the data point properties.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredDataPoint {
  @doc("The name of the discovered data point.")
  name?: string;

  @doc("The address of the source of the data in the discovered asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  capabilityId?: string;

  @doc("Timestamp indicating when the datapoint was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@doc("Defines the event properties.")
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
model DiscoveredEvent {
  @doc("The name of the discovered event.")
  name?: string;

  @doc("The address of the notifier of the event in the discovered asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  capabilityId?: string;

  @doc("Timestamp indicating when the event was added or modified.")
  lastUpdatedOn?: utcDateTime;
}

@armResourceOperations
@added(global.Private.DeviceRegistry.Versions.v2024_07_01_preview)
interface DiscoveredAssets {
  get is ArmResourceRead<DiscoveredAsset>;

  createOrReplace is ArmResourceCreateOrReplaceAsync<DiscoveredAsset>;

  update is ArmResourcePatchAsync<DiscoveredAsset, DiscoveredAssetProperties>;

  delete is ArmResourceDeleteWithoutOkAsync<DiscoveredAsset>;

  listByResourceGroup is ArmResourceListByParent<DiscoveredAsset>;

  listBySubscription is ArmListBySubscription<DiscoveredAsset>;
}
