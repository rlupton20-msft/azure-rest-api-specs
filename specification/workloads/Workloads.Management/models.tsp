using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Azure.ResourceManager.Foundations;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint"
namespace Private.Workloads;

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

/** WorkloadResourceDefinition properties */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" ""
model WorkloadResourceDefinitionProperties {
  /** The description of the workload definition. */
  description: string;

  /** The workload specification. */
  workloadSpecification: WorkloadSpecification;

  /** The key value pair storing the workload definition specific properties. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties object"
  @doc("Mutable key value pairs.")
  annotations?: Record<string>;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** WorkloadSpecification model representing the workload definition. */
model WorkloadSpecification {
  /** The version of the workload definition. */
  version: string;

  /** The definition ID (GUID) of the workload. */
  definitionId: string;

  /** The name of the workload. */
  scope: string;

  /** The nodes to be created. */
  @OpenAPI.extension("x-ms-identifiers", [])
  nodes: Nodes[];

  /** The routes between the nodes. */
  @OpenAPI.extension("x-ms-identifiers", [])
  routes: Routes[];
}

/** Node model representing the resources to be created. */
model Nodes {
  /** The node ID. */
  nodeId: string;

  /** The name of the node. */
  nodename: string;

  /** The name of the component (or) application layer */
  component: string;

  /** The name of the role within the application (or) component. */
  role: string;

  /** Defines the type of the node. */
  nodetype: string;

  /** The Azure resource type to be linked. */
  resourceType: string;

  /** The resource SKU. */
  resourceSku: string;

  /** The minimum number of resources that the user can create. */
  @minValue(1)
  minResourceCount: int32;

  /** The key-value pair for storing node specific custom (or) additional details. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "properties defines the node specific details with the type as Record<any>"
  additionalDetails: Record<string>;
}

/** Route model represening the linkage between nodes. */
model Routes {
  /** The route ID (Unique GUID). */
  routeId: string;

  /** The Id of the source node. */
  sourceNodeId: string;

  /** The Id of the target node. */
  targetNodeId: string;

  /** The relation ship between source and target node. */
  relationShip: string;
}
