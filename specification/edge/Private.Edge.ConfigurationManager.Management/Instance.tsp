import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionBinding.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Instance State")
union ActiveState {
  @doc("Instance is active")
  Active: "Active",

  @doc("Instance is inactive")
  Inactive: "Inactive",

  string,
}

@doc("Component Status")
model ComponentStatus {
  @doc("Target name")
  name: string;

  @doc("component status")
  status: string;
}

@doc("Target Status")
model TargetStatus {
  @doc("Target name")
  name: string;

  @doc("target status")
  status: string;

  @doc("component statuses")
  @extension("x-ms-identifiers", [])
  componentStatuses: ComponentStatus[];
}

@doc("Deployment Status")
model DeploymentStatus {
  @doc("The lastModified of the Status")
  lastModified: utcDateTime;

  @doc("Indicates if Instance is deployed")
  deployed: int32;

  @doc("The expected running job id")
  expectedRunningJobId: int32;

  @doc("The running job id")
  runningJobId: int32;

  @doc("Deployment status")
  status: string;

  @doc("status details")
  statusDetails: string;

  @doc("deployment Generation")
  generation: int32;

  @doc("target resource statuses")
  @extension("x-ms-identifiers", [])
  targetStatuses?: TargetStatus[];
}

@doc("Instance Properties")
model InstanceProperties {
  @doc("Solution version of instance")
  @visibility("read")
  solutionVersionId: string;

  @doc("Target of instance")
  @visibility("read")
  targetId: string;

  @doc("State of instance")
  @visibility("read")
  activeState?: ActiveState;

  @doc("Scope of instance")
  solutionScope?: string;

  @doc("Status of instance")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  status: DeploymentStatus;

  @doc("Deployment timestamp of instance")
  @visibility("read")
  deploymentTimestampEpoch: int64;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Instance Resource")
@parentResource(Solution)
model Instance is ProxyResource<InstanceProperties> {
  // Name will be set to solution
  ...ResourceNameParameter<Instance>;
}

@armResourceOperations
interface Instances {
  @doc("Get Instance Resource")
  get is ArmResourceRead<Instance>;

  @doc("Create or update Instance Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Instance>;

  @doc("update an Instance Resource")
  update is ArmResourcePatchSync<Instance, InstanceProperties>;

  @doc("Delete Instance Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Instance>;

  @doc("List Instance Resources")
  listByTarget is ArmResourceListByParent<Instance>;
}
