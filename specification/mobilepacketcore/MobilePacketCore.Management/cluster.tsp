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

@doc("Azure for Operators 5G Core Cluster Resource")
@resource("clusters")
model ClusterResource is TrackedResource<ClusterResourceProperties> {
  @doc("The name of the Cluster")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterName")
  @path
  @segment("clusters")
  @visibility("create", "read")
  name: string;
}

@doc("Cluster Properties.")
model ClusterResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Cluster deployment type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Unity Cloud Release Version.  This is applied to all platform as a service (PaaS) components and running workloads in this cluster")
  unityCloudRelease: UnityCloudRelease;

  @doc("Cluster type specific data.  Contents depend on the cluster type")
  clusterTypeSpecificData: ClusterTypeSpecificData;

  @doc("Unity Cloud Local PaaS federation parameters.  One set per federation type")
  @extension("x-ms-identifiers", ["type"])
  unityCloudFederationParameters: UnityCloudDeploymentParameters[];

  @doc("Billing Details")
  @visibility("read")
  billingDetails?: BillingDetails;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;
}

@armResourceOperations(ClusterResource)
interface Clusters {
  get is ArmResourceRead<ClusterResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ClusterResource>;
  updateTags is ArmTagsPatchSync<ClusterResource>;
  delete is ArmResourceDeleteSync<ClusterResource>;
  listByResourceGroup is ArmResourceListByParent<ClusterResource>;
  listBySubscription is ArmListBySubscription<ClusterResource>;
}

@doc("Cluster type specific data.")
@discriminator("type")
model ClusterTypeSpecificData {
  @doc("Cluster Type")
  type: ClusterType;

  @doc("Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("AKS Cluster specific data.")
model AksClusterData extends ClusterTypeSpecificData {
  @doc("Azure Kubernetes Service Properties.")
  type: ClusterType.Aks;
}

@doc("Nexus AKS Cluster specific data.")
model NexusAksClusterData extends ClusterTypeSpecificData {
  @doc("Nexus Operator Kubenetes Service Properties.")
  type: ClusterType.NexusAks;
}

@doc("Cluster Type Definitions")
enum ClusterType {
  @doc("Azure Kubernetes Service")
  Aks,

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks,
}
