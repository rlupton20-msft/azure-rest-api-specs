import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Reference to a Nexus Trunked Network resource.")
scalar NexusTrunkedNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/trunkedNetworks",
    }
  ]>;

@doc("Reference to an Edge Virtual Network")
scalar EdgeVirtualNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes/packetCoreDataPlanes/edgeVirtualNetworks",
    }
  ]>;

@doc("Reference to an Edge Network Security Group Resource")
scalar EdgeNetworkSecurityGroupResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/edgeNetworkSecurityGroups",
    }
  ]>;

@doc("Reference to a site resource.")
scalar SiteResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/sites",
    }
  ]>;

@doc("Reference to an Azure Stack Edge device resource.")
scalar AzureStackEdgeDeviceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.DataBoxEdge/dataBoxEdgeDevices",
    }
  ]>;

@doc("Reference to an Azure Stack HCI cluster resource.")
scalar AzureStackHCIClusterResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.AzureStackHCI/clusters",
    }
  ]>;

@doc("Reference to a Nexus Edge Cluster resource.")
scalar NexusEdgeClusterResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/edgeClusters",
    }
  ]>;

@doc("Reference to an Azure Arc custom location resource.")
scalar ConnectedClusterResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters",
    }
  ]>;

@doc("Reference to an Azure Arc custom location resource.")
scalar CustomLocationResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;

@doc("Reference to a Nexus Cloud Services Network resource.")
scalar NexusCloudServicesNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/cloudServicesNetworks",
    }
  ]>;

@doc("Reference to a Nexus L3 Network resource.")
scalar NexusL3NetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.NetworkCloud/l3Networks",
    }
  ]>;

@doc("Reference to an attached data network resource.")
scalar AttachedDataNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes/packetCoreDataPlanes/attachedDataNetworks",
    }
  ]>;

@doc("Reference to a SIM policy resource.")
scalar SimPolicyResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/simPolicies",
    }
  ]>;

@doc("Reference to a slice resource.")
scalar SliceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/slices",
    }
  ]>;

@doc("Reference to a SIM group resource.")
scalar SimGroupResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/simGroups",
    }
  ]>;

@doc("Reference to a mobile network resource.")
scalar MobileNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks",
    }
  ]>;

@doc("Reference to a data network resource.")
scalar DataNetworkResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/dataNetworks",
    }
  ]>;

@doc("Reference to a service resource.")
scalar ServiceResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/mobileNetworks/services",
    }
  ]>;

@doc("Reference to an packet core control plane resource.")
scalar PacketCoreControlPlaneResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/packetCoreControlPlanes",
    }
  ]>;

@doc("Reference to a cluster service resource.")
scalar ClusterServiceResourceId
  extends Azure.ResourceManager.ResourceIdentifier<[
    {
      type: "Microsoft.MobileNetwork/clusterServices",
    }
  ]>;
