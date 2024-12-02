import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core.Foundations;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "ZeroTrustSegmentationClient",
})
@versioned(Versions)
@doc("ZeroTrustSegmentation resource provider API.")
namespace Microsoft.ZeroTrustSegmentation;

/** ZeroTrustSegmentation API versions */
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_05_01_preview: "2025-02-01-preview",
}

@doc("A zero trust segmentation resource. this resource defines the SegmentationManager.")
model SegmentationManager is TrackedResource<SegmentationManagerProperties> {
  @doc("Name of the segmentation manager")
  @key("segmentationManagerName")
  @pattern("^[a-zA-Z0-9-]{3,250}$")
  @path
  @segment("segmentationManagers")
  name: string;
}

@doc("Segmentation manager properties")
model SegmentationManagerProperties {
  @doc("The collection of ARM resource IDs for the monitored logs.")
  logSources: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/networkWatchers/flowLogs";
    }
  ]>[];

  @doc("The analysis run type")
  analysisRunType: AnalysisRunType;

  @doc("The start time of a snapshot run")
  startTime?: utcDateTime;

  @doc("The end time of a snapshot run")
  endTime?: utcDateTime;

  @doc("Enable/disable automatic labeling functionality")
  enableAutomaticSegmentation: AutomaticSegmentationState;

  @doc("The description of the segmentation manager")
  description?: string;

  ...DefaultProvisioningStateProperty;
  ...ManagedByProperty;
}

@doc("Automatic segmentation labeling functionality state")
union AutomaticSegmentationState {
  string,

  @doc("Automatic segmentation is enabled")
  Enabled: "Enabled",

  @doc("Automatic segmentation is disabled")
  Disabled: "Disabled",
}

@doc("Analysis run type")
union AnalysisRunType {
  string,

  @doc("Single run")
  OneTime: "OneTime",

  @doc("Continuous run")
  Continuous: "Continuous",
}

@doc("Set label record")
model SetLabelRecord {
  @doc("IP address of the workload")
  ipAddress: string;

  @doc("MAC address of the workload")
  macAddress: string;

  @doc("Application label")
  appLabel?: string;

  @doc("Environment label")
  envLabel?: string;

  @doc("Role label")
  roleLabel?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Additional labels as key-value pairs")
  additionalLabels?: Record<string>;
}

@doc("The request model for the SetLabels API")
model SetLabelsRequest {
  @doc("Tenant ID")
  tenantid: string;

  @doc("List of labels that need to be updated")
  @OpenAPI.extension("x-ms-identifiers", [])
  labels: SetLabelRecord[];
}

@doc("The request model for the GetGraph API")
model GetGraphRequest {
  @doc("The start time of the graph")
  startTime: utcDateTime;

  @doc("The end time of the graph")
  endTime: utcDateTime;
}

@doc("The response model for the GetGraph API")
model GetGraphResponse {
  @doc("Graph representation")
  graph: Graph;
}

@doc("Graph representaion model")
model Graph {
  @doc("List of vertices in the graph")
  vertices: Vertex[];

  @doc("List of edges connecting the vertices in the graph")
  @OpenAPI.extension("x-ms-identifiers", [])
  edges: Edge[];
}

@doc("Vertex model representing a node in the network")
model Vertex {
  @doc("Unique identifier for the vertex")
  id: string;

  @doc("IP address of the vertex")
  ipAddress: string;

  @doc("MAC address of the vertex")
  macAddress: string;

  @doc("Geographical location of the vertex")
  @visibility("read", "create")
  location: string;

  @doc("Azure Resource Manager ID of the vertex")
  armId?: string;

  @doc("Name of the vertex")
  name?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Labels associated with the vertex as key-value pairs")
  labels: Record<string>;
}

@doc("Edge model representing a connection between two vertices")
model Edge {
  @doc("Source vertex ID")
  source: string;

  @doc("Target vertex ID")
  target: string;

  @doc("Timestamp of the edge in milliseconds since epoch")
  hourT: int64;

  @doc("Traffic weights associated with the edge")
  trafficWeights: TrafficWeights;
}

@doc("TrafficWeights model")
model TrafficWeights {
  @doc("Incoming packet weight as a percentage")
  inPktWeight: float32;

  @doc("Incoming byte weight as a percentage")
  inByteWeight: float32;

  @doc("Incoming connection weight as a percentage")
  inConnWeight: float32;

  @doc("Outgoing packet weight as a percentage")
  outPktWeight: float32;

  @doc("Outgoing byte weight as a percentage")
  outByteWeight: float32;

  @doc("Outgoing connection weight as a percentage")
  outConnWeight: float32;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface SegmentationManagers {
  get is ArmResourceRead<SegmentationManager>;
  createOrReplace is ArmResourceCreateOrReplaceSync<SegmentationManager>;
  update is ArmResourcePatchSync<
    SegmentationManager,
    SegmentationManagerProperties
  >;
  delete is ArmResourceDeleteSync<SegmentationManager>;
  listByResourceGroup is ArmResourceListByParent<SegmentationManager>;
  listBySubscription is ArmListBySubscription<SegmentationManager>;

  setLabels is ArmResourceActionNoContentSync<
    SegmentationManager,
    SetLabelsRequest
  >;

  getGraph is ArmResourceActionSync<
    SegmentationManager,
    GetGraphRequest,
    GetGraphResponse
  >;
}
