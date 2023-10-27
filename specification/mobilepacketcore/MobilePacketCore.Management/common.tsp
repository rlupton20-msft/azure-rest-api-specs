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

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdate2Async<
  TResource extends Azure.ResourceManager.Foundations.ArmResource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @body
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("ARM resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.ArmResource>
  is ArmResponse<TResource>;

@pattern("^([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})$")
scalar IPv4Address extends string;

@pattern("^([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3}).([0-9]{1,3})/[0-9]{1,2}$")
scalar IPv4Cidr extends string;

@pattern("^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$")
scalar Ipv6Address extends string;

@doc("Provisioning state of the resource")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource is getting provisioned")
  Provisioning,

  @doc("Resource is updating")
  Updating,

  @doc("Resource is getting deleted")
  Deleting,

  @doc("Resource has been accepted")
  Accepted,
}

@doc("ARM resource ID of the vnet subnet.")
scalar VnetSubnetIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets",
    }
  ]>;

@doc("ARM resource ID of the security group.")
scalar SecurityGroupIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/networkSecurityGroups",
    }
  ]>;

@doc("ARM resource ID of the Cloud Service Network.")
scalar CloudServiceNetworkIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/cloudServicesNetworks",
    }
  ]>;

@doc("ARM resource ID of the Network Fabric.")
scalar NetworkFabricIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/networkFabrics",
    }
  ]>;

@doc("ARM resource ID of the L3 Isolation Domain.")
scalar L3IsolationDomainIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.ManagedNetworkFabric/l3IsolationDomains",
    }
  ]>;

@doc("ARM resource ID of a cluster.")
scalar ClusterIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/clusters",
    }
  ]>;

@doc("ARM resource ID of a EMS deployment.")
scalar EmsDeploymentIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.MobilePacketCore/emsDeployments",
    }
  ]>;

@doc("ARM resource ID of a connected cluster.")
scalar ConnectedClusterIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters",
    }
  ]>;

@doc("ARM resource ID of a custom location.")
scalar CustomLocationIdProperty
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;

@doc("Azure Availability Zones.")
enum AvailabilityZone {
  @doc("No availability zone")
  None,

  @doc("Zone 1")
  `1`,

  @doc("Zone 2")
  `2`,

  @doc("Zone 3")
  `3`,
}

@doc("Common attributes for L2 networks for cloud workload network on Nexus")
model NexusL2NetworkProperties {
  @doc("Vlan Identifier. Example: 501.")
  @minValue(100)
  @maxValue(4094)
  vlanId: int32;

  @doc("Maximum transmission unit. Default value is 1500.")
  @minValue(64)
  @maxValue(9200)
  mtu: int32 = 1500;
}

@doc("Common attributes for L3 networks for both fabric internal network and cloud workload network on Nexus")
model NexusL3NetworkProperties {
  @doc("ip prefix of the connected IPv4 Subnet. The first three usable IP addresses for internal use")
  subnetPrefix: IPv4Cidr;

  @doc("Vlan Identifier. Example: 501.")
  @minValue(100)
  @maxValue(4094)
  vlanId: int32;

  @doc("Maximum transmission unit. Default value is 1500.")
  @minValue(64)
  @maxValue(9200)
  mtu: int32 = 1500;

  @doc("BGP Peer ASN. Example: 65047.")
  @minValue(1)
  @maxValue(65535)
  bgpPeerAsn?: int32;

  @doc("BGP Ipv4 Listen Range.")
  bgpListenRangePrefixes?: IPv4Cidr[];

  @doc("List of static routes for network fabric L3 internal networks.")
  @extension("x-ms-identifiers", ["prefix", "nextHop"])
  staticRouteConfiguration?: Ipv4StaticRouteConfiguration[];
}

@doc("IPv4 Static Route Configuration")
model Ipv4StaticRouteConfiguration {
  @doc("ip prefix of the static route")
  prefix: IPv4Cidr;

  @doc("List of next hop ipv4 addresses.")
  nextHop: IPv4Address[];
}

@doc("Operational Status of the resource")
model OperationalStatus {
  @doc("Status of the deployed workloads")
  @visibility("read")
  workload?: string;

  @doc("Health check results")
  @visibility("read")
  healthCheck?: string;
}

@doc("Infrastructure Type Definitions")
enum InfrastructureType {
  @doc("Azure Core")
  AzureCore,

  @doc("Azure Operator Nexus")
  AzureOperatorNexus,
}

@doc("Cluster Type Definitions")
enum ClusterType {
  @doc("Azure Kubernetes Service")
  Aks,

  @doc("Azure Operator Nexus Kubernetes Service")
  NexusAks,
}

@doc("Deployment Type Definitions")
enum SkuDeploymentType {
  @doc("Producton Deployment")
  Production,

  @doc("Lab Deployment")
  Lab,
}

@doc("Usage SKU Definition")
scalar UsageSku extends string;

@doc("Mobile Core Scaling Unit SKU Definition")
scalar MobileCoreScalingUnitSku extends string;

@doc("Billing Details")
model BillingDetails {
  @doc("Mobile Core Scaling Unit SKU")
  @visibility("read")
  mobileCoreScalingUnitSku?: MobileCoreScalingUnitSku;

  @doc("Usage SKU")
  @visibility("read")
  usageSku?: UsageSku;

  @doc("Mobile Core Scaling Units (MCSU)")
  @visibility("read")
  mobileCoreScalingUnits?: float32;

  @doc("Simultaneously Attached Users (SAU)")
  @visibility("read")
  simultaneouslyAttachedUsersCount?: int32;

  @doc("PDN/PDU Sessions")
  @visibility("read")
  sessionCount?: int32;
}

@doc("UnityCloud Release definition.")
scalar UnityCloudRelease extends string;

@doc("Virtual MME Release definition.")
scalar VirtualMmeRelease extends string;

@doc("EMS Release definition.")
scalar EmsRelease extends string;

@doc("Product Name.")
enum ProductName {
  @doc("UnityCloud product line")
  UnityCloud,
}

@doc("MME Parameters")
scalar MmeParameters extends string;

@doc("MME Secrets")
scalar MmeSecrets extends string;

@doc("EMS Parameters")
scalar EmsParameters extends string;

@doc("EMS Secrets")
scalar EmsSecrets extends string;

@doc("UnityCloud Federation Parameters")
scalar UnityCloudFederationParameters extends string;

@doc("UnityCloud Federation Type")
scalar UnityCloudFederationType extends string;

@doc("UnityCloud Deployment Parameters")
model UnityCloudDeploymentParameters {
  @doc("Federaton Type")
  type: UnityCloudFederationType;

  @doc("Usage Definition")
  parameters: UnityCloudFederationParameters;
}
