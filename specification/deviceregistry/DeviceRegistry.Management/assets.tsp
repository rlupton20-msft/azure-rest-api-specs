import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/extendedLocation.tsp";
import "./common/provisioningState.tsp";
import "./common/topic.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Asset definition.")
model Asset is TrackedResource<AssetProperties> {
  @doc("Asset name parameter.")
  @key("assetName")
  @segment("assets")
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

@doc("Defines the asset properties.")
model AssetProperties {
  @doc("Globally unique, immutable, non-reusable id.")
  @visibility("read")
  uuid?: string;

  @doc("Resource path to asset type (model) definition.")
  @removed(Versions.v2024_07_01_preview)
  assetType?: string;

  @doc("Enabled/Disabled status of the asset.")
  enabled?: boolean;

  @doc("Asset id provided by the customer.")
  @visibility("read", "create")
  externalAssetId?: string;

  @doc("Human-readable display name.")
  displayName?: string;

  @doc("Human-readable description of the asset.")
  description?: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides datapoints for this asset. Must have the format <ModuleCR.metadata.namespace>/<ModuleCR.metadata.name>.")
  @visibility("read", "create")
  @removed(Versions.v2024_07_01_preview)
  assetEndpointProfileUri: string;

  @doc("A reference to the asset endpoint profile (connection information) used by brokers to connect to an endpoint that provides datapoints for this asset. Must provide asset endpoint profile name.")
  @visibility("read", "create")
  @added(Versions.v2024_07_01_preview)
  assetEndpointProfileRef: string;

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility("read")
  version?: int32;

  @doc("Asset manufacturer name.")
  manufacturer?: string;

  @doc("Asset manufacturer URI.")
  manufacturerUri?: string;

  @doc("Asset model name.")
  // `model` is a reserved keyname. Wrap in double quotes
  `model`?: string;

  @doc("Asset product code.")
  productCode?: string;

  @doc("Revision number of the hardware.")
  hardwareRevision?: string;

  @doc("Revision number of the software.")
  softwareRevision?: string;

  @doc("Reference to the documentation.")
  documentationUri?: string;

  @doc("Asset serial number.")
  serialNumber?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "attributes property field is custom defined by customer"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Reference to a list of discovered assets. Populated only if the asset has been created from discovery flow. Discovered asset names must be provided.")
  @visibility("read", "create")
  @added(Versions.v2024_07_01_preview)
  discoveredAssetRefs?: string[];

  @doc("Stringified JSON that contains protocol-specific default configuration for all datapoints. Each datapoint can have its own configuration that overrides the default settings here.")
  @removed(Versions.v2024_07_01_preview)
  defaultDataPointsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all datasets. Each dataset can have its own configuration that overrides the default settings here.")
  @added(Versions.v2024_07_01_preview)
  defaultDatasetsConfiguration?: string;

  @doc("Stringified JSON that contains connector-specific default configuration for all events. Each event can have its own configuration that overrides the default settings here.")
  defaultEventsConfiguration?: string;

  @doc("Object that describes the default topic information for the asset.")
  @added(Versions.v2024_07_01_preview)
  defaultTopic?: Topic;

  @doc("Array of datapoints that are part of the asset. Each datapoint can reference an asset type capability and have per-datapoint configuration.")
  @removed(Versions.v2024_07_01_preview)
  @extension("x-ms-identifiers", [])
  dataPoints?: Datapoint[];

  @doc("Array of datasets that are part of the asset. Each dataset describes the datapoints that make up the set.")
  @added(Versions.v2024_07_01_preview)
  @extension("x-ms-identifiers", [])
  datasets?: Dataset[];

  @doc("Array of events that are part of the asset. Each event can have per-event configuration.")
  @extension("x-ms-identifiers", [])
  events?: Event[];

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility("read")
  status?: AssetStatus;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Defines the dataset properties.")
@added(Versions.v2024_07_01_preview)
model Dataset {
  @doc("Name of the dataset.")
  name: string;

  @doc("Stringified JSON that contains connector-specific JSON string that describes configuration for the specific dataset.")
  datasetConfiguration?: string;

  @doc("Object that describes the topic information for the specific dataset.")
  topic?: Topic;

  @doc("Array of datapoints that are part of the dataset. Each datapoint can have per-datapoint configuration.")
  @extension("x-ms-identifiers", [])
  datapoints?: Datapoint[];
}

@doc("Defines the datapoint properties.")
@renamedFrom(Versions.v2024_07_01_preview, "DataPointBase")
model DatapointBase {
  @doc("The name of the datapoint.")
  @madeRequired(Versions.v2024_07_01_preview)
  name: string;

  @doc("The address of the source of the data in the asset (e.g. URL) so that a client can access the data source on the asset.")
  dataSource: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  @removed(Versions.v2024_07_01_preview)
  capabilityId?: string;

  @doc("An indication of how the datapoint should be mapped to OpenTelemetry.")
  @removed(Versions.v2024_07_01_preview)
  observabilityMode?: DataPointsObservabilityMode = DataPointsObservabilityMode.None;

  @doc("Stringified JSON that contains connector-specific configuration for the datapoint. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  @renamedFrom(Versions.v2024_07_01_preview, "dataPointConfiguration")
  datapointConfiguration?: string;
}

// workaround done to define a default after breaking change on enum values
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Defines the datapoint properties.")
@renamedFrom(Versions.v2024_07_01_preview, "DataPoint")
model Datapoint extends DatapointBase {
  @doc("An indication of how the datapoint should be mapped to OpenTelemetry.")
  @added(Versions.v2024_07_01_preview)
  observabilityMode?: DatapointsObservabilityMode = DatapointsObservabilityMode.None;
}

@doc("Defines the datapoint observability mode.")
@removed(Versions.v2024_07_01_preview)
union DataPointsObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  None: "none",

  @doc("Map as counter to OpenTelemetry.")
  Counter: "counter",

  @doc("Map as gauge to OpenTelemetry.")
  Gauge: "gauge",

  @doc("Map as histogram to OpenTelemetry.")
  Histogram: "histogram",

  @doc("Map as log to OpenTelemetry.")
  Log: "log",

  string,
}

@doc("Defines the datapoint observability mode.")
@added(Versions.v2024_07_01_preview)
union DatapointsObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  None: "None",

  @doc("Map as counter to OpenTelemetry.")
  Counter: "Counter",

  @doc("Map as gauge to OpenTelemetry.")
  Gauge: "Gauge",

  @doc("Map as histogram to OpenTelemetry.")
  Histogram: "Histogram",

  @doc("Map as log to OpenTelemetry.")
  Log: "Log",

  string,
}

@doc("Defines the event properties.")
model EventBase {
  @doc("The name of the event.")
  @madeRequired(Versions.v2024_07_01_preview)
  name: string;

  @doc("The address of the notifier of the event in the asset (e.g. URL) so that a client can access the event on the asset.")
  eventNotifier: string;

  @doc("The path to the type definition of the capability (e.g. DTMI, OPC UA information model node id, etc.), for example dtmi:com:example:Robot:_contents:__prop1;1.")
  @removed(Versions.v2024_07_01_preview)
  capabilityId?: string;

  @doc("An indication of how the event should be mapped to OpenTelemetry.")
  @removed(Versions.v2024_07_01_preview)
  observabilityMode?: EventsObservabilityMode = EventsObservabilityMode.None;

  @doc("Stringified JSON that contains connector-specific configuration for the event. For OPC UA, this could include configuration like, publishingInterval, samplingInterval, and queueSize.")
  eventConfiguration?: string;

  @doc("Object that describes the topic information for the specific event.")
  @added(Versions.v2024_07_01_preview)
  topic?: Topic;
}

// workaround done to define a default after breaking change on enum values
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
@doc("Defines the event properties.")
model Event extends EventBase {
  @doc("An indication of how the event should be mapped to OpenTelemetry.")
  @added(Versions.v2024_07_01_preview)
  observabilityMode?: EventObservabilityMode = EventObservabilityMode.None;
}

@doc("Defines the event observability mode.")
@removed(Versions.v2024_07_01_preview)
union EventsObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  @removed(Versions.v2024_07_01_preview)
  None: "none",

  @doc("Map as log to OpenTelemetry.")
  @removed(Versions.v2024_07_01_preview)
  Log: "log",

  string,
}

@doc("Defines the event observability mode.")
@added(Versions.v2024_07_01_preview)
union EventObservabilityMode {
  @doc("No mapping to OpenTelemetry.")
  @added(Versions.v2024_07_01_preview)
  None: "None",

  @doc("Map as log to OpenTelemetry.")
  @added(Versions.v2024_07_01_preview)
  Log: "Log",

  string,
}

@doc("Defines the asset status properties.")
model AssetStatus {
  @doc("Array object to transfer and persist errors that originate from the Edge.")
  @extension("x-ms-identifiers", [])
  errors?: AssetStatusError[];

  @doc("A read only incremental counter indicating the number of times the configuration has been modified from the perspective of the current actual (Edge) state of the Asset. Edge would be the only writer of this value and would sync back up to the cloud. In steady state, this should equal version.")
  version?: int32;

  @doc("Array of dataset statuses that describe the status of each dataset.")
  @added(Versions.v2024_07_01_preview)
  @extension("x-ms-identifiers", [])
  datasets?: AssetStatusDataset[];

  @doc("Array of event statuses that describe the status of each event.")
  @added(Versions.v2024_07_01_preview)
  @extension("x-ms-identifiers", [])
  events?: AssetStatusEvent[];
}

@doc("Defines the asset status error properties.")
model AssetStatusError {
  @doc("Error code for classification of errors (ex: 400, 404, 500, etc.).")
  code?: int32;

  @doc("Human readable helpful error message to provide additional context for error (ex: “capability Id 'foo' does not exist”).")
  message?: string;
}

@doc("Defines the asset status dataset properties.")
@added(Versions.v2024_07_01_preview)
model AssetStatusDataset {
  @doc("The name of the dataset. Must be unique within the status.datasets array. This name is used to correlate between the spec and status dataset information.")
  name: string;

  @doc("The message schema reference object.")
  messageSchemaReference?: MessageSchemaReference;
}

@doc("Defines the asset status event properties.")
@added(Versions.v2024_07_01_preview)
model AssetStatusEvent {
  @doc("The name of the event. Must be unique within the status.events array. This name is used to correlate between the spec and status event information.")
  name: string;

  @doc("The message schema reference object.")
  messageSchemaReference?: MessageSchemaReference;
}

@doc("Defines the message schema reference properties.")
@added(Versions.v2024_07_01_preview)
model MessageSchemaReference {
  @doc("The reference to the message schema registry namespace.")
  schemaRegistryNamespace: string;

  @doc("The reference to the message schema name.")
  schemaName: string;

  @doc("The reference to the message schema version.")
  schemaVersion: string;
}

@armResourceOperations
interface Assets {
  get is ArmResourceRead<Asset>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Asset>;
  update is ArmResourcePatchAsync<Asset, AssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Asset>;
  listByResourceGroup is ArmResourceListByParent<Asset>;
  listBySubscription is ArmListBySubscription<Asset>;
}
