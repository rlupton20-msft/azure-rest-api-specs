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

@doc("Azure for Operators 5G Core virtual MME/SGSN Deployment Resource")
@resource("mmeDeployments")
model MmeDeploymentResource
  is TrackedResource<MmeDeploymentResourceProperties> {
  @doc("The name of the MME Deployment")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]$")
  @minLength(1)
  @maxLength(63)
  @key("mmeDeploymentName")
  @path
  @segment("mmeDeployments")
  @visibility("create", "read")
  name: string;
}

@doc("MME Deployment Properties.")
model MmeDeploymentResourceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Usage SKU")
  @visibility("create", "read")
  usageSku: UsageSku;

  @doc("Mobile Core Scaling Unit SKU")
  @visibility("create", "read")
  mobileCoreScalingUnitSku: MobileCoreScalingUnitSku;

  @doc("Deployment status")
  @visibility("read")
  deploymentStatus?: DeploymentStatus;

  @doc("Mobile Core Scaling Units (MCSU)")
  @visibility("read")
  actualMobileCoreScalingUnits?: float32;

  @doc("Simultaneously Attached Users (SAU)")
  @visibility("read")
  simultaneouslyAttachedUsersCount?: int32;

  @doc("EMS instance managing this MME")
  @visibility("read", "create")
  emsDeployment: EmsDeploymentIdProperty;

  @doc("MME deployment profile")
  @visibility("read", "create")
  deploymentProfile: MmeDeploymentProfile;

  @doc("MME deployment NFVI type specific data")
  @visibility("read", "create")
  typeSpecificData: MmeDeploymentProfileTypeSpecificData;

  @doc("MME Release Version")
  mmeRelease: VirtualMmeRelease;

  @doc("Floating IPv4 address for Management Access")
  managementFloatingIp: IPv4Address;
}

@armResourceOperations(MmeDeploymentResource)
interface MmeDeployments {
  get is ArmResourceRead<MmeDeploymentResource>;
  createOrUpdate is ArmResourceCreateOrUpdate2Async<MmeDeploymentResource>;
  updateTags is ArmTagsPatchSync<MmeDeploymentResource>;
  delete is ArmResourceDeleteSync<MmeDeploymentResource>;
  listByResourceGroup is ArmResourceListByParent<MmeDeploymentResource>;
  listBySubscription is ArmListBySubscription<MmeDeploymentResource>;
}

/* Type definitions */
@doc("MME Profile properties. The format of the VM count is <num of MRM>-<Num of MSM> or <num of MGMT>-<Num of RM>-<num of CallP>-<num of SIG>-<Num of LB>-<num of DATA>")
enum MmeDeploymentProfile {
  @doc("Azure Lab SKU")
  MME2VM_SMALL_1_1,

  @doc("Azure Lab SKU")
  MME2VM_MEDIUM_2_2,

  @doc("Azure Lab SKU")
  MME2VM_LARGE_2_8,

  @doc("Azure Lab SKU")
  MME6VM_SMALL_1_1_1_1_1_0,

  @doc("Azure Lab SKU")
  MME6VM_SMALL_1_1_1_1_1_1,

  @doc("Azure Lab SKU")
  MME6VM_SMALL_2_2_2_2_2_2,

  @doc("Azure Lab SKU")
  MME6VM_SMALL_2_2_2_2_2_0,

  @doc("Azure Lab SKU")
  MME6VM_MEDIUM_2_2_2_2_2_2,

  @doc("Azure Lab SKU")
  MME6VM_MEDIUM_2_2_2_2_2_0,

  @doc("Azure Lab SKU")
  MME6VM_MEDIUM_2_2_4_3_2_2,

  @doc("Azure Lab SKU")
  MME6VM_MEDIUM_2_2_4_3_2_0,

  @doc("Azure Lab SKU")
  MME6VM_LARGE_2_2_20_10_5_4,

  @doc("Azure Lab SKU")
  MME6VM_LARGE_2_2_20_10_5_0,
}

@doc("MME Deployment Profile type specific data.")
@discriminator("type")
model MmeDeploymentProfileTypeSpecificData {
  @doc("NFVI Type")
  type: InfrastructureType;
}

@doc("MME Deployment Profile Azure Core specific data.")
model MmeDeploymentProfileAzureCoreData
  extends MmeDeploymentProfileTypeSpecificData {
  @doc("MME Deployment Properties.")
  type: InfrastructureType.AzureCore;

  @doc("Management subnet information for MME deployments")
  @visibility("create", "read")
  managementSubnet: MmeManagementSubnet;

  @doc("North/south subnet for MME deployments")
  @visibility("create", "read")
  northSouthSubnet: MmeNorthSouthSubnet;

  @doc("North/south data subnet for MME deployments")
  @visibility("create", "read")
  northSouthDataSubnet: MmeNorthSouthSubnet;

  @doc("ARM resource ID of the security group for internal traffic")
  @visibility("create", "read")
  internalSecurityGroupId: SecurityGroupIdProperty;

  @doc("IP pools for management traffic where the subnetId is taken from the management Subnet of containing NFVi instance, e.g. 172.32.0.0/24")
  @visibility("create", "read")
  managementIpPool: MmeExternalIpPool;

  @doc("IP pools from which the floating IP is assigned where the subnetId is taken from the OAM Subnet of containing NFVi instance, e.g. 172.32.6.0/24")
  @visibility("create", "read")
  oamIpPool: MmeExternalIpPool;

  @doc("IP pools for north/south control plane traffic where the subnetId is taken from the north/south of containing NFVi instance")
  @visibility("create", "read")
  northSouthIpPool: MmeExternalIpPool;

  @doc("IP pools for north/south data plane traffic where the subnetId is taken from the north/south-data of containing NFVi instance")
  @visibility("create", "read")
  northSouthDataIpPool: MmeExternalIpPool;

  @doc("The base network subnet")
  baseNetwork: MmeInternalSubnet;

  @doc("The east/west network subnet")
  eastWestNetwork: MmeInternalSubnet;

  @doc("Comma separated list of Interface IP addresses for the mgmt interface on the MGMT/MRM VMs in the cluster.")
  mgmtIfIps: string;

  @doc("Comma separated list of IP addresses assigned to the Base Interface. These IPs would be assigned to Base interfaces in MGMT VMs in the order (mgmt-0, mgmt-1).")
  mgmtBaseIfIps: string;

  @doc("Comma separated list of IP addresses assigned to the Data Interface. These IPs would be assigned to Data interfaces in MGMT VMs in the order (mgmt-0, mgmt-1).")
  mgmtDataIfIps: string;

  @doc("Comma separated list of IP addresses assigned to the LB/MSM VM NS1 Interface. These IPs would be used assigned to North/South 1 interfaces in LB/MSM VMs in the order (lb-0 ... lb-n) or (msm0-0, msm0-1, msm1-0 ... msmX-Y).")
  northSouth1Ips: string;

  @doc("Comma separated list of IP addresses assigned to the DATA VM NS1 Interface. These IPs would be used assigned to North/South 1 interfaces in DATA VMs in the order (data-0 ... data-n). Required only if DATA VM is part of the deployment profile.")
  northSouthData1Ips: string;

  @doc("Loopback configuration for LB VMs.")
  loopbackConfig: MmeLoopbackConfig[];

  @doc("Loopback configuration for LB VMs.")
  dataLoopbackConfig: MmeDataLoopbackConfig[];

  @doc("Availability zone for cluster side A.")
  availabilityZoneA?: AvailabilityZone;

  @doc("Availability zone for cluster side B.")
  availabilityZoneB?: AvailabilityZone;
}

@doc("Azure for Operators 5G Core MME Deployment Resource")
model MmeProfileAzureOperatorNexusData
  extends MmeDeploymentProfileTypeSpecificData {
  @doc("MME Deployment Properties.")
  type: InfrastructureType.AzureOperatorNexus;

  @doc("ARM Resource ID of the Network Fabric")
  @visibility("create", "read")
  networkFabricId: NetworkFabricIdProperty;

  @doc("ARM Resource ID of the Cloud Service Network shared by MME deployments")
  @visibility("create", "read")
  cloudServiceNetworkId: CloudServiceNetworkIdProperty;

  @doc("ARM Resource ID of the L3 Isolation Domain for management traffic")
  @visibility("create", "read")
  managementL3IsolationDomainId: L3IsolationDomainIdProperty;

  @doc("ARM Resource ID of the L3 Isolation Domain for north/south traffic")
  @visibility("create", "read")
  northSouthL3IsolationDomainId: L3IsolationDomainIdProperty;

  @doc("Management Network")
  @visibility("create", "read")
  managementL3Network: NexusL3NetworkProperties;

  @doc("Access Network")
  @visibility("create", "read")
  accessL3Network: NexusL3NetworkProperties;

  @doc("Core Network")
  @visibility("create", "read")
  coreL3Network: NexusL3NetworkProperties;

  @doc("Base Network")
  @visibility("create", "read")
  baseL2Network: NexusL2NetworkProperties;

  @doc("Data Network")
  @visibility("create", "read")
  dataL2Network: NexusL2NetworkProperties;

  @doc("Comma separated list of Interface IP addresses for the mgmt interface on the MGMT/MRM VMs in the cluster.")
  mgmtIfIps: string;
}

@doc("MME Management subnet definition.")
model MmeManagementSubnet {
  @visibility("create", "read")
  @doc("ARM resource ID of the vnet subnet")
  subnetId: VnetSubnetIdProperty;

  @visibility("create", "read")
  @doc("The CIDR of the address pool partition from the subnet address space.  E.g. 10.0.0.0/24")
  poolPrefix: IPv4Cidr;

  @doc("ARM resource ID of the security group")
  @visibility("create", "read")
  securityGroupId: SecurityGroupIdProperty;
}

@doc("MME External IP Pool definition.")
model MmeExternalIpPool {
  @visibility("create", "read")
  @doc("ARM resource ID of the vnet subnet")
  subnetId: VnetSubnetIdProperty;

  @visibility("create", "read")
  @doc("The CIDR of the address pool partition from the subnet address space.  E.g. 10.0.0.0/24")
  poolPrefix: IPv4Cidr;
}

@doc("Common attributes for internal subnet provisioning.")
model MmeInternalSubnet {
  @visibility("create", "read")
  @doc("ARM resource ID of the vnet subnet")
  subnetId: VnetSubnetIdProperty;

  @visibility("create", "read")
  @doc("The CIDR of the subnet.  E.g. 10.0.0.0/24")
  subnetPrefix: IPv4Cidr;
}

@doc("North/South network usage")
enum NorthSouthNetworkUsage {
  @doc("Usage 1")
  NorthSouth1,

  @doc("Usage 2")
  NorthSouth2,

  @doc("Usage 3")
  NorthSouth3,

  @doc("Usage 4")
  NorthSouth4,

  @doc("Usage 5")
  NorthSouth5,
}

@doc("Common attributes for external subnet provisioning.")
model MmeNorthSouthSubnet {
  @visibility("create", "read")
  @doc("Vnet subnet usage")
  usage: NorthSouthNetworkUsage;

  @visibility("create", "read")
  @doc("ARM resource ID of the vnet subnet")
  subnetId: VnetSubnetIdProperty;

  @doc("ARM resource ID of the security group")
  @visibility("create", "read")
  securityGroupId: SecurityGroupIdProperty;
}

@doc("Loopback configuration for LB VMs")
model MmeLoopbackConfig {
  @doc("The 3GPP loopback IP address")
  ip: IPv4Address;

  @doc("ARM resource ID of the loopback subnet")
  subnetId: VnetSubnetIdProperty;
}

@doc("MME VM Service")
enum MmeVmService {
  @doc("data-0")
  data0,

  @doc("data-1")
  data1,

  @doc("data-2")
  data2,

  @doc("data-3")
  data3,

  @doc("data-4")
  data4,

  @doc("data-5")
  data5,

  @doc("data-6")
  data6,

  @doc("data-7")
  data7,

  @doc("data-8")
  data8,

  @doc("data-9")
  data9,

  @doc("data-10")
  data10,

  @doc("data-11")
  data11,

  @doc("data-12")
  data12,

  @doc("data-13")
  data13,

  @doc("data-14")
  data14,

  @doc("data-15")
  data15,
}

@doc("Loopback configuration for Data VMs")
model MmeDataLoopbackConfig {
  @doc("A 3GPP loopback IP address")
  ip: IPv4Address;

  @doc("MME VM service")
  vmService: MmeVmService;
}
