import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@service({
  title: "Deployment Settings",
  version: "2023-08-01-preview",
})
@doc("Azure Stack HCI Deployment Settings.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.AzureStackHCI;

@doc("A Cluster")
model Clusters is TrackedResource<ClusterProperties> {
  @key("clusterName")
  @doc("Name of Cluster")
  @segment("clusters")
  name: string;
}

@doc("The deployment mode of deployment settings for a cluster.")
enum DeploymentMode {
  @doc("Validate deployment settings for cluster.")
  Validate,
  @doc("Deploy cluster using  deployment settings.")
  Deploy
}

@doc("A ClusterProperties")
model ClusterProperties {
}

@doc("Edge device resource")
@parentResource(Clusters)
model DeploymentSetting is ProxyResource<DeploymentSettingsProperties> {
  @doc("Name of Deployment Setting")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("deploymentSettings")
  @key("deploymentSettingsName")
  @path
  name: string = "default"
}

@doc("DeploymentSetting properties")
model DeploymentSettingsProperties {
  @doc("DeploymentSetting provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState,

  @doc("ARM resource ids of Arc machines to be part of cluster.")
  @extension("x-ms-identifiers", [])
  "arcNodeResourceIds" : string[],

  @doc("Deployment mode can have values 'validate' or 'deploy'.")
  "deploymentMode" : DeploymentMode = DeploymentMode.Deploy,

  @doc("Scale units will contains list of deploymentdata")
  @extension("x-ms-identifiers", [])
  deploymentConfiguration : DeploymentConfiguration,

  @doc("Deployment Status reported from cluster.")
  @visibility("read")
  reportedProperties?: ReportedProperties
}

@doc("Deployment Configuration")
model DeploymentConfiguration {
  @doc("deployment template version ")
  version?: string,

  @doc("Scale units will contains list of deploymentdata")
  @extension("x-ms-identifiers", [])
  scaleUnits : ScaleUnits[]
}


@doc("Scale units will contains list of deploymentdata")
@externalDocs("https://learn.microsoft.com/en-us/azure-stack/hci/deploy/deployment-tool-existing-file", 
"Deploy Azure Stack HCI using an existing configuration file")
model ScaleUnits {
 @doc("Deployment Data to deploy AzureStackHCI Cluster.")
  deploymentData: DeploymentData,
  // @doc("Deployment metatdata to pass additional config.")
  // deploymentMetaData?: string,
}

// @doc("DeploymentSetting properties")
// model DeploymentSettingsProperties {
//   @doc("DeploymentSetting provisioning state")
//   @visibility("read")
//   provisioningState?: ProvisioningState,

//   @doc("Deployment Data to deploy AzureStackHCI Cluster.")
//   deploymentData: DeploymentData,

//   @doc("Deployment metatdata to pass additional config.")
//   deploymentMetaData?: string,

//   @doc("Deployment Status reported from cluster.")
//   @visibility("read")
//   reportedProperties?: ReportedProperties
// }

@doc("The DeploymentData of AzureStackHCI Cluster.")
model DeploymentData {
  @doc("SecuritySettings to deploy AzureStackHCI Cluster.")
  securitySettings: SecuritySettings,
  @doc("Observability config to deploy AzureStackHCI Cluster.")
  observability: Observability,
  @doc("Observability config to deploy AzureStackHCI Cluster.")
  cluster: Cluster,
  @doc("Storage config to deploy AzureStackHCI Cluster.")
  storage: Storage,
  @doc("naming prefix to deploy cluster.")
  @pattern("^[a-zA-Z0-9-]{1,8}$")
  namingPrefix : string,
  @doc("FQDN to deploy cluster")
  domainFqdn: string,
  @doc("InfrastructureNetwork config to deploy AzureStackHCI Cluster.")
  @extension("x-ms-identifiers", [])
  infrastructureNetwork: InfrastructureNetwork[],
  @doc("list of perhysicalNodes config to deploy AzureStackHCI Cluster.")
  @extension("x-ms-identifiers", [])
  physicalNodes : PhysicalNodes[],
  @doc("HostNetwork config to deploy AzureStackHCI Cluster.")
  "hostNetwork" : HostNetwork,

  @doc("The path to the Active Directory Organizational Unit (ADOU) container object prepared for the deployment. ")
  "adouPath" : string,
  @doc("The URI to the keyvault / secret store.")
  @extension("x-ms-secret", true)
  secretsLocation? : string,
  @doc("OptionalServices config to deploy AzureStackHCI Cluster.")
  optionalServices?: OptionalServices
}



@doc("The DeploymentStatus of AzureStackHCI Cluster.")
model ReportedProperties {
  @doc("validaton status of AzureStackHCI Cluster Deployment.")
  @visibility("read")
  validatonStatus?: ValidationStatus,
  @doc("Deployment status of AzureStackHCI Cluster Deployment.")
  @visibility("read")
  deploymentStatus?: DeploymentStatus
}


@doc("The ValidationStatus of AzureStackHCI Cluster.")
model ValidationStatus {
  @doc("Status of AzureStackHCI Cluster Deployment.")
  @visibility("read")
  status?: string,

  @doc("List of steps of AzureStackHCI Cluster Deployment.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps?: Step[]
}

@doc("The DeploymentStatus of AzureStackHCI Cluster.")
model DeploymentStatus {
  @doc("Status of AzureStackHCI Cluster Deployment.")
  @visibility("read")
  status?: string,

  @doc("List of steps of AzureStackHCI Cluster Deployment.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps?: Step[]
}


@doc("The Step of AzureStackHCI Cluster.")
model Step {
  @doc("Name of step.")
  @visibility("read")
  name?: string,

  @doc("Description of step.")
  @visibility("read")
  description?: string,

   @doc("FullStepIndex of step.")
   @visibility("read")
  fullStepIndex?: string,

 
 @doc("Start time of step.")
  @visibility("read")
  startTimeUtc?: string,

  @doc("End time of step.")
  @visibility("read")
  endTimeUtc?: string,

    @doc("Status of step. Allowed values are 'Error', 'Success', 'InProgress'")
  @visibility("read")
  status?: string,

  @doc("List of nested steps of AzureStackHCI Cluster Deployment.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps?: Step[],

  @doc("List of exceptions in AzureStackHCI Cluster Deployment.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  exception?: string[]
}

@doc("The SecuritySettings of AzureStackHCI Cluster.")
model SecuritySettings {

  @doc("By default, Hypervisor-protected Code Integrity (HVCI) is enabled on your Azure HCI cluster.")
  hvciProtection: boolean = true,
  @doc("By default, Secure Boot is enabled on your Azure HCI cluster. This setting is hardware dependent.")
  drtmProtection: boolean = true,
  @doc("When set to true, the security baseline is re-applied regularly.")
  driftControlEnforced: boolean = true,
  @doc("When set to true, Credential Guard is enabled.")
  credentialGuardEnforced: boolean = false,
  @doc("When set to true, the SMB default instance requires sign in for the client and server services.")
  smbSigningEnforced: boolean = true,
  @doc("When set to true, cluster east-west traffic is encrypted.")
  smbClusterEncryption: boolean = false,
  @doc("When set to true, all the side channel mitigations are enabled")
  sideChannelMitigationEnforced: boolean = true,
  @doc("When set to true, BitLocker XTS_AES 256-bit encryption is enabled for all data-at-rest on the OS volume of your Azure Stack HCI cluster. This setting is TPM-hardware dependent. ")
  bitlockerBootVolume: boolean = true,
  @doc("When set to true, BitLocker XTS-AES 256-bit encryption is enabled for all data-at-rest on your Azure Stack HCI cluster shared volumes.")
  bitlockerDataVolumes: boolean = true,
  @doc("WDAC is enabled by default and limits the applications and the code that you can run on your Azure Stack HCI cluster.")
  wdacEnforced: boolean = true
}

@doc("The Observability of AzureStackHCI Cluster.")
model Observability {

  @doc("Enables telemetry data to be sent to Microsoft")
  streamingDataClient: boolean = true,
  @doc("Location of your cluster. The log and diagnostic data is sent to the appropriate diagnostics servers depending upon where your cluster resides. Setting this to false results in all data sent to Microsoft to be stored outside of the EU.")
  euLocation: boolean = false,
  @doc("When set to true, collects log data to facilitate quicker issue resolution.")
  episodicDataUpload: boolean = true,
}

@doc("The OptionalServices of AzureStackHCI Cluster.")
model OptionalServices {
  @doc("The name of custom location.")
  customLocation?: string
}

@doc("AzureStackHCI Cluster deployment properties.")
model Cluster {
  @doc("The cluster name provided when preparing Active Directory.")
  name: string,
  @doc("Use a cloud witness if you have internet access and if you use an Azure Storage account to provide a vote on cluster quorum. A cloud witness uses Azure Blob Storage to read or write a blob file and then uses it to arbitrate in split-brain resolution. Only allowed values are 'Cloud', 'FileShare'. ")
  witnessType: string,
  @doc("Specify the fileshare path for the local witness for your Azure Stack HCI cluster.")
  witnessPath: string,
  @doc("Specify the Azure Storage account name for cloud witness for your Azure Stack HCI cluster.")
  cloudAccountName: string,
  @doc("For Azure blob service endpoint type, select either Default or Custom domain. If you selected **Custom domain, enter the domain for the blob service in this format core.windows.net.")
  azureServiceEndpoint: string
}

@doc("The Storage config of AzureStackHCI Cluster.")
model Storage {
  @doc("By default, this mode is set to Express and your storage is configured as per best practices based on the number of nodes in the cluster. Allowed values are 'Express','InfraOnly', 'KeepStorage'")
  "configurationMode": string = "Express"
}

@doc("The InfrastructureNetwork of a AzureStackHCI Cluster.")
model InfrastructureNetwork {
  @doc("Subnet mask that matches the provided IP address space.")
  subnetMask: string,
  @doc("Default gateway that should be used for the provided IP address space.")
  gateway: string,
  @doc("Range of IP addresses from which addresses are allocated for nodes within a subnet.")
  @extension("x-ms-identifiers", [])
  ipPools: IpPools[],
  @doc("IPv4 address of the DNS servers in your environment.")
  dnsServers: string[]
}

@doc("The PhysicalNodes of a cluster.")
model PhysicalNodes {
  @doc("NETBIOS name of each physical server on your Azure Stack HCI cluster.")
  name: string,
  @doc("The IPv4 address assigned to each physical server on your Azure Stack HCI cluster.")
  ipv4Address: string,
}

@doc("The dnsServers of a device.")
model IpPools {
   @doc("Starting IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.")
  startingAddress: string,
   @doc("Ending IP address for the management network. A minimum of six free, contiguous IPv4 addresses (excluding your host IPs) are needed for infrastructure services such as clustering.")
  endingAddress: string,
}

@doc("The HostNetwork of a cluster.")
model HostNetwork {
  @doc("The network intents assigned to the network reference pattern used for the deployment. Each intent will define its own name, traffic type, adapter names, and overrides as recommended by your OEM.")
  @extension("x-ms-identifiers", [])
  intents: Intents[],

  @doc("List of StorageNetworks config to deploy AzureStackHCI Cluster.")
  @extension("x-ms-identifiers", [])
  "storageNetworks": StorageNetworks[],
  
  @doc("storageConnectivitySwitchless for AzureStackHCI Cluster.")
  "storageConnectivitySwitchless": boolean
}

@doc("The Intents of a cluster.")
model Intents {
  @doc("Name of the network intent you wish to create.")
  name: string,
  @doc("List of network traffic types. Only allowed values are 'Compute', 'Storage', 'Management'.")
  trafficType: string[],
  @doc("Array of network interfaces used for the network intent.")
  adapter: string[],
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideVirtualSwitchConfiguration: boolean = false,
  @doc("Set virtualSwitch ConfigurationOverrides for cluster.")
  virtualSwitchConfigurationOverrides?: VirtualSwitchConfigurationOverrides,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideQosPolicy: boolean = false,
  @doc("Set QoS PolicyOverrides for cluster.")
  qosPolicyOverrides?: QosPolicyOverrides,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  overrideAdapterProperty: boolean = false,
  @doc("Set Adapter PropertyOverrides for cluster.")
  adapterPropertyOverrides?: AdapterPropertyOverrides,
}

@doc("The StorageNetworks of a cluster.")
model StorageNetworks {
  @doc("Name of the storage network.")
  name: string,
  @doc("Name of the storage network adapter.")
  networkAdapterName: string,
  @doc("ID specified for the VLAN storage network. This setting is applied to the network interfaces that route the storage and VM migration traffic. ")
  vlanId: string
}

@doc("The VirtualSwitchConfigurationOverrides of a cluster.")
model VirtualSwitchConfigurationOverrides {
  @doc("Enable IoV for Virtual Switch")
  enableIov?: string,
  @doc("Load Balancing Algorithm for Virtual Switch")
  loadBalancingAlgorithm?: string
}

@doc("The QoSPolicyOverrides of a cluster.")
model QosPolicyOverrides {
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  priorityValue8021Action_Cluster?: string,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  priorityValue8021Action_SMB?: string,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  bandwidthPercentage_SMB?: string
}

@doc("The AdapterPropertyOverrides of a cluster.")
model AdapterPropertyOverrides {
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  jumboPacket?: string,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation.")
  networkDirect?: string,
  @doc("This parameter should only be modified based on your OEM guidance. Do not modify this parameter without OEM validation. Expected values are 'iWARP', 'RoCEv2', 'RoCE'")
  networkDirectTechnology?: string
}

// @doc("The ConfigurationMode of a resource.")
// enum ConfigurationMode {
//   @doc("By default, this mode is set to Express and your storage is configured as per best practices based on the number of nodes in the cluster.")
//   Express,
// }

// @doc("The TrafficType of a resource.")
// enum Status {
//   @doc("Error")
//   Error,
//   @doc("Success")
//   Success,
//   @doc("InProgress")
//   InProgress
// }

// @doc("The TrafficType of a resource.")
// enum TrafficType {
//   @doc("Compute")
//   Compute,
//   @doc("Management")
//   Management,
//   @doc("Storage")
//   Storage
// }

// @doc("The WitnessType of a resource.")
// enum WitnessType {
//   @doc("Cloud")
//   Cloud,

//   @doc("FileShare")
//   FileShare,
// }

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The resource provision state is not specified")
  NotSpecified,

  @doc("The resource is being provisioned")
  Provisioning,

  @doc("The resource is updating")
  Updating,

  @doc("The resource is being deleted")
  Deleting,

  @doc("The resource create request has been accepted")
  Accepted,
}

@doc("The deployment request for Azure Stack HCI Cluster.")
model DeploymentRequest{
  @doc("deployment request type, allowed values 'ValidateOnly', Deploy', 'ValidateAndDeployIfSuccess'")
  requestType: string
}

@doc("An Accepted response with an Operation-Location header.")
model DeploymentResponse{
  @doc("The status code.")
  @statusCode
  statusCode: 202;
}

// @doc("deployment request type.")
// enum DeploymentRequest {
//   @doc("ValidateOnly")
//   ValidateOnly,

//   @doc("Deploy")
//   Deploy,

//   @doc("ValidateAndDeployIfSuccess")
//   ValidateAndDeployIfSuccess,
// }

// interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface DeploymentSettings {
  get is ArmResourceRead<DeploymentSetting>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeploymentSetting>;
  delete is ArmResourceDeleteWithoutOkAsync<DeploymentSetting>;
  listByParent is ArmResourceListByParent<DeploymentSetting>;
  deploy is ArmResourceActionAsync<DeploymentSetting, DeploymentRequest, DeploymentResponse>;
}


