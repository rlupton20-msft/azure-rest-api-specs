import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using OpenAPI;

namespace Microsoft.MobilePacketCore;

@added(Versions.v2024_03_15_preview)
@doc("Azure for Operators VNF Agent Deployment Resource")
@resource("vnfAgentDeployments")
model VnfAgentDeploymentResource
  is TrackedResource<VnfAgentDeploymentResourceProperties> {
  @doc("The name of the VNF Agent Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("vnfAgentDeploymentName")
  @path
  @segment("vnfAgentDeployment")
  @visibility("create", "read")
  name: string;
}

@added(Versions.v2024_03_15_preview)
@doc("VNF Agent Deployment Properties.")
model VnfAgentDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Azure for Operators 5G Core VNF Agent component parameters")
  componentParameters?: ComponentDeploymentParameters;

  @doc("Azure for Operators 5G Core VNF Agent secrets parameters")
  @visibility("create", "update")
  secretsParameters?: ComponentDeploymentSecrets;

  @doc("Reference to cluster where the Network Function is deployed")
  @visibility("create", "read")
  clusterService: ClusterServiceIdProperty;

  @doc("Release version. This is inherited from the cluster")
  @visibility("read")
  releaseVersion?: ReleaseVersion;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("Associated Virtual Network Function resource identifiers")
  @visibility("read")
  associatedVirtualNetworkFunctions?: AssociatedVirtualNetworkFunctionIdProperty[];
}

@added(Versions.v2024_03_15_preview)
@armResourceOperations(VnfAgentDeploymentResource)
interface VnfAgentDeployments {
  get is ArmResourceRead<VnfAgentDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<VnfAgentDeploymentResource>;
  updateTags is ArmTagsPatchSync<VnfAgentDeploymentResource>;
  delete is ArmResourceDeleteWithoutOkAsync<VnfAgentDeploymentResource>;
  @doc("List all VNF Agent Deployments by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<VnfAgentDeploymentResource>;
  @doc("List all VNF Agent Deployments by Subscription ID.")
  listBySubscription is ArmListBySubscription<VnfAgentDeploymentResource>;
}
