import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
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
  title: "AzureStackHCI",
  version: "2023-08-01-preview",
})
@doc("Azure Stack HCI management service")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.AzureStackHCI;

///remove it//////
@doc("A Cluster")
model Clusters is TrackedResource<ClusterProperties> {
  @key("clusterName")
  @doc("Name of Cluster")
  @segment("clusters")
  name: string
}
@doc("A ClusterProperties")
model ClusterProperties {
}

@doc("Validation / deployment status details for Job.")
model EceActionStatus {
  @doc("Job status.")
  @visibility("read")
  status?: string,

  @doc("List of steps of cluster job.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps?: Step[]
}

@doc("Step details during job execution.")
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

  @doc("List of nested steps during job execution..")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  steps?: Step[],

  @doc("List of exceptions in job execution.")
  @extension("x-ms-identifiers", [])
  @visibility("read")
  exception?: string[]
}

@doc("Protected parameters list stored in keyvault.")
model EceDeploymentSecrets {
  @doc("Secret name stored in keyvault.")
  secretName?: string,
  @doc("Secret name expected for job execution.")
  eceSecretName?: EceSecrets,
  @doc("Secret URI stored in keyvault.")
  @format("uri")
  secretLocation?: string
}

@doc("Secret names allowed for Enterprise Cloud Engine (ECE) deployment.")
enum EceSecrets {
    @doc("AzureStackLCMUserCredential used for LCM operations for AzureStackHCI cluster.")
    AzureStackLCMUserCredential,

    @doc("DefaultARBApplication used to manage Azure Arc resource bridge (ARB) for AzureStackHCI cluster.")
    DefaultARBApplication,

    @doc("LocalAdminCredential used for admin operations for AzureStackHCI cluster.")
    LocalAdminCredential,

    @doc("WitnessStorageKey used for setting up a cloud witness for AzureStackHCI cluster.")
    WitnessStorageKey
}

@doc("The deployment mode of ECE action for a cluster.")
enum DeploymentMode {
  @doc("Validate ECE action deployment for a cluster.")
  Validate,
  @doc("Deploy ECE action deployment for a cluster.")
  Deploy
}

model HostNetwork
{
  
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  @doc("The resource provision state is Succeeded")
  Succeeded, 

  @doc("The resource provision state is Failed")
  Failed, 

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
//////////


////////////////////////////////////////////////////////////////////////////////
////////add below models in common for cluster and edgedevice jobs////////
////////////////////////////////////////////////////////////////////////////////
@doc("Reported Properties for cluster job triggered from cloud.")
model JobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32,

  @doc("Validation status of ob.")
  @visibility("read")
  validationStatus? : EceActionStatus,

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus? : EceActionStatus
}


@doc("Edge solution type.")
enum EdgeSolutionType {
  @doc("Edge solution for Azure stack HCI edge devices.")
  AzureStackHCI,

  @doc("Edge solution for Azure linux edge devices.")
  AzureLinux
}

@doc("Common Job Types supported.")
enum JobType {
 @doc("AddServer")
 AddServer,

 @doc("RepairServer")
  RepairServer
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@doc("Jobs resource")
@parentResource(Clusters)
@discriminator("kind")
model Job is ProxyResource<ClusterJobProperties> {
  @doc("Name of Job")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("jobs")
  @key("jobsName")
  @path
  name: string,

  @doc("Edge Solution type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  kind: EdgeSolutionType
}

@doc("Cluster Job properties")
model ClusterJobProperties {
  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy,

  @doc("List of ARM resource ids of Arc machines part of cluster for which job will be trigerred.")
  @extension("x-ms-identifiers", [])
  @extension("x-ms-mutability", ["create", "read"])
  arcNodeResourceIds? : string[],

  // read-only properties below
  @doc("Job provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState,

  @doc("Unique, immutable job id.")
  @visibility("read")
  jobId?: string,
  
  @doc("The UTC date and time at which the job started.")
  @visibility("read")
  startTimeUtc?: utcDateTime,

  @doc("The UTC date and time at which the job completed.")
  @visibility("read")
  endTimeUtc?: utcDateTime,

  @doc("Status of Cluster job. Allowed values are 'Failed', 'Success', 'Running', 'canceled'")
  @visibility("read")
  status?: string,

  @doc("Reported properties for job")
  @visibility("read")
  reportedProperties?: JobReportedProperties
}

////////////////////////////////////////////////////////////////////////////////
////////Add JobProperties for common cluster jobs///////
////////////////////////////////////////////////////////////////////////////////
model AddServerJobProperties extends ClusterJobProperties{
  @doc("Name of server to be added to cluster.")
  serverName: string,

  @doc("Ip address of server to be added to cluster.")
  hostIpv4Address: string,

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[]  
}

model RepairServerJobProperties extends ClusterJobProperties{

  @doc("Name of server to be repaired in cluster.")
  serverName: string,

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[]
}

model PauseServerJobProperties extends ClusterJobProperties{

  @doc("Trigger pause job for given server name in cluster.")
  serverName: string,

  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy,
}

model ResumeServerJobProperties extends ClusterJobProperties{

  @doc("Trigger resume job for given server name in cluster.")
  serverName: string,

  @doc("Deployment mode to trigger job.")
  deploymentMode?: DeploymentMode = DeploymentMode.Deploy,

}
////////////////////////////////////////////////////////////////////////////////
////////end common jobs
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////define all AzureStack HCI jobs in below section///////
////////////////////////////////////////////////////////////////////////////////
@doc("Cluster job for Azure Stack HCI solution.")
model AzureStackHciJob extends Job{
  kind: EdgeSolutionType.AzureStackHCI,
  properties: HciClusterJobProperties
}

@discriminator("jobType") 
@doc("HCI Cluster Job properties")
model HciClusterJobProperties extends ClusterJobProperties {
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: HciJobType
}

@doc("Job Type supported.")
enum HciJobType {
  //inherit common jobs
          ...JobType,

  // add HCI specific jobs
 @doc("ResumeServer")
  ResumeServer,

  @doc("PauseServer")
  PauseServer,

  @doc("AddNetworkIntent")
  AddNetworkIntent,

  @doc("SetInformation")
  SetInformation,
}

model HciAddServerJobProperties extends HciClusterJobProperties{
  ...AddServerJobProperties,
  @doc("AddServer Job Type.")
  jobType: HciJobType.AddServer
}

model HciRepairServerJobProperties extends HciClusterJobProperties{
  ...RepairServerJobProperties,
  @doc("Repair Server Job Type.")
  jobType: HciJobType.RepairServer
}

model HciResumeServerJobProperties extends HciClusterJobProperties{
  ...ResumeServerJobProperties,
  @doc("Resume Server Job Type.")
  jobType: HciJobType.ResumeServer
}

model HciPauseServerJobProperties extends HciClusterJobProperties{
  ...PauseServerJobProperties,
  @doc("PauseServer Job Type.")
  jobType: HciJobType.PauseServer
}

model HciAddNetworkIntentJobProperties extends HciClusterJobProperties{
  @doc("AddNetworkIntent Job Type.")
  jobType: HciJobType.AddNetworkIntent,

  @doc("List of protected parameters to pass to trigger job for cluster.")
  @extension("x-ms-identifiers", ["secretName"])
  secrets?: EceDeploymentSecrets[],

  @doc("HostNetwork properties to set network intent.")
  hostNetwork?: HostNetwork
}

model HciSetInformationJobProperties extends HciClusterJobProperties{
  @doc("SetInformation Job Type.")
  jobType: HciJobType.SetInformation,
  @doc("Set to represent if the system is configured in a switchless or switched configuration.")
  Switchless?: boolean,

  @doc("A string with a list of comma-separated name of the network adapters to use for the storage intent.")
  StorageIntentAdapters?: string,

  @doc("A string with the name of the storage intent. If not provided a default one storage is used.")
  Name?: string,

  @doc("A string with a list of comma-separated vlan ids to use which should map exactly and in order to the adapters provided in StorageIntentAdapters. If not provided the system uses the defaults set by Network ATC.")
  VlanId?: string,

  @doc("A string with the size to be set for Jumb packet frame size for the storage adapters.")
  JumboPacket?: string,

  @doc("A string to be set to enabled or disabled to specify if network direct mode should be enabled/disabled.")
  NetworkDirect?: string,

  @doc("A string that specifies the network direct technology to be used. Possible values are iWARP, RoCE and RoCEv2.")
  NetworkDirectTechnology?: string,

  @doc("A string to specify the 802.1Q priority for the cluster.")
  PriorityValue8021Action_Cluster?: string,

  @doc("A string to specify the 802.1Q priority for SMB.")
  PriorityValue8021Action_SMB?: string,

  @doc("A string to specify the bandwidth percentage to be used for SMB.")
  BandwidthPercentage_SMB?: string,
}
////////end AzureStack HCI jobs///////
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
////////Start AzureLinux jobs///////
////////////////////////////////////////////////////////////////////////////////
@doc("Cluster job for Azure Linux solution.")
model AzureLinuxJob extends Job{
  kind: EdgeSolutionType.AzureLinux,
  properties: AzureLinuxClusterJobProperties
}

@doc("Job Type supported.")
enum AzureLinuxJobType  {
    // inherit common jobs
          ...JobType,

    //define Azure Linux specific job types
    @doc("EnableSsh")
    EnableSsh
}

@discriminator("jobType") 
@doc("Cluster Job properties")
model AzureLinuxClusterJobProperties extends ClusterJobProperties {
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxJobType
}

model AzureLinuxAddServerJobProperties extends AzureLinuxClusterJobProperties{
  ...AddServerJobProperties,

  @doc("AddServer Job Type.")
  jobType: AzureLinuxJobType.AddServer,

  @doc("ssh user name.")
  sshUser: string,
}

model AzureLinuxRepairServerJobProperties extends AzureLinuxClusterJobProperties{
 ...RepairServerJobProperties,

  @doc("AddServer Job Type.")
  jobType: AzureLinuxJobType.RepairServer,

  @doc("ssh user name.")
  sshUser: string,
}

////////end AzureLinux jobs///////
////////////////////////////////////////////////////////////////////////////////

// interface Operations extends Azure.ResourceManager.Operations {}
@armResourceOperations
interface Jobs {
  get is ArmResourceRead<Job>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Job>;
  delete is ArmResourceDeleteWithoutOkAsync<Job>;
  listByParent is ArmResourceListByParent<Job>;
}