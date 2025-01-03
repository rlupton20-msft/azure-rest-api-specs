import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionVersion.tsp";
import "./Target.tsp";
import "./Instance.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Instance History Properties")
model InstanceHistoryProperties {
  @doc("Solution version of instance")
  @visibility("read")
  solutionVersion: SolutionVersion;

  @doc("Target of instance")
  @visibility("read")
  target: Target;

  @doc("Deployment Status of instance")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  deploymentStatus: DeploymentStatus[];

  @doc("Deployment timestamp of instance")
  @visibility("read")
  deploymentTimestampEpoch: int64;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("InstanceHistory Resource")
@parentResource(Instance)
model InstanceHistory is ProxyResource<InstanceHistoryProperties> {
  ...ResourceNameParameter<
    InstanceHistory,
    // Name will be set to solutionVersion-deploymentTimestamp
    NamePattern = "^[a-zA-Z0-9-]{3,40}$"
  >;
}

@armResourceOperations
interface InstanceHistories {
  @doc("Get InstanceHistory Resource")
  get is ArmResourceRead<InstanceHistory>;

  @doc("Create or update InstanceHistory Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<InstanceHistory>;

  @doc("update an InstanceHistory Resource")
  update is ArmResourcePatchSync<InstanceHistory, InstanceHistoryProperties>;

  @doc("Delete InstanceHistory Resource")
  delete is ArmResourceDeleteSync<InstanceHistory>;

  @doc("List InstanceHistory Resources")
  listByInstance is ArmResourceListByParent<InstanceHistory>;
}
