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

/** WorkloadVirtualInstances properties */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" ""
model WorkloadVirtualInstanceProperties {
  /** The Arm resource Id for workload resource definition. */
  workloadResourceDefinitionId: string;

  /** The configuration of workload roles (or) tiers. */
  @OpenAPI.extension("x-ms-identifiers", [])
  roleConfigurations: RoleConfigurations[];

  /** The key value pair storing the workload definition specific properties. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties object"
  @doc("Mutable key value pairs.")
  annotations?: Record<string>;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** Configuration of roles in workload. */
model RoleConfigurations {
  /** The name of the component (or) application layer */
  component: string;

  /** The name of the role within the application (or) component. */
  role: string;

  /** The name of the workload. */
  @OpenAPI.extension("x-ms-identifiers", [])
  resourceConfigurations: ResourceConfigurations[];
}

/** The configuration of all resources under the workload role. */
model ResourceConfigurations {
  /** The resource category. */
  resourceCategory: string;

  /** The type of resource. */
  resourceType: string;

  /** The resource SKU. */
  @OpenAPI.extension("x-ms-identifiers", [])
  resourceIds: string[];

  /** The key-value pair for storing node specific custom (or) additional details. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "properties defines the node specific details with the type as Record<any>"
  additionalDetails: Record<string>;
}
