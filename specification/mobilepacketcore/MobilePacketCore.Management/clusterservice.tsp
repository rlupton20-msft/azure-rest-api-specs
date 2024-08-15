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

@doc("Azure for Operators 5G Core Cluster Service Resource")
@resource("clusterServices")
model ClusterServiceResource
  is TrackedResource<ClusterServiceResourceProperties> {
  @doc("The name of the Cluster Service")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("clusterServiceName")
  @path
  @segment("clusterServices")
  @visibility("create", "read")
  name: string;
}

@doc("Cluster Service Properties.")
model ClusterServiceResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Cluster type (Lab or Production)")
  @visibility("create", "read")
  deploymentType: SkuDeploymentType;

  @doc("Azure for Operators 5G Core Release Version.  This is applied to all platform as a service (PaaS) components and running workloads in this cluster")
  releaseVersion: ReleaseVersion;

  @doc("Cluster type specific data.  Contents depend on the cluster type")
  clusterTypeSpecificData: ClusterServiceClusterTypeSpecificData;

  @doc("Azure for Operators 5G Core Local PaaS component parameters.  One set per component type")
  @extension("x-ms-identifiers", ["type"])
  componentParameters: QualifiedComponentDeploymentParameters[];

  @doc("OIDC Issuer URL for the Cluster Service to create the federated credentials")
  oidcIssuerUrl: URL;

  @doc("User Assigned Managed Identity (UAMI) resource identifier that has access to the customer provided Azure Key Vault")
  uamiResourceId: UamiIdPropertyIdProperty;

  @doc("Operational status")
  @visibility("read")
  operationalStatus?: OperationalStatus;

  @doc("Associated cluster workload resource identifiers")
  @visibility("read")
  associatedWorkloadResources?: AssociatedClusterWorkloadIdProperty[];
}

@armResourceOperations(ClusterServiceResource)
interface ClusterServices {
  get is ArmResourceRead<ClusterServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<ClusterServiceResource>;
  updateTags is ArmTagsPatchSync<ClusterServiceResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ClusterServiceResource>;
  @doc("List all Cluster Services by Resource Group.")
  listByResourceGroup is ArmResourceListByParent<ClusterServiceResource>;
  @doc("List all Cluster Services by Subscription ID.")
  listBySubscription is ArmListBySubscription<ClusterServiceResource>;
}

@doc("Cluster Service cluster type specific data.")
@discriminator("type")
model ClusterServiceClusterTypeSpecificData {
  @doc("Cluster Type")
  type: ClusterType;

  @doc("Kubernetes Service Custom Location resource ID")
  customLocationId: CustomLocationIdProperty;
}

@doc("AKS Cluster specific data.")
model ClusterServiceAksClusterData
  extends ClusterServiceClusterTypeSpecificData {
  @doc("Azure Kubernetes Service Properties.")
  type: ClusterType.Aks;
}

@doc("Nexus AKS Cluster specific data.")
model ClusterServiceNexusAksClusterData
  extends ClusterServiceClusterTypeSpecificData {
  @doc("Nexus Operator Kubenetes Service Properties.")
  type: ClusterType.NexusAks;

  @doc("Operator Nexus Cluster Custom Location resource ID")
  nexusCustomLocationId: CustomLocationIdProperty;
}
