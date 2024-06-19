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
  title: "Edge device Jobs",
  version: "2023-12-01-preview",
})
@doc("Edge device Jobs")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.AzureStackHCI;

///remove it//////
@doc("Edge device resource")
@discriminator("kind") 
model EdgeDevice is ExtensionResource<EdgeDeviceProperties> {
  @doc("Name of Device")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("edgeDeviceName")
  @path
  @segment("edgeDevices")
  name: string = "default",
}
@doc("A EdgeDeviceProperties")
model EdgeDeviceProperties {
}

@doc("Validation / deployment status details for Job.")
model EceActionStatus {
  @doc("Job status.")
  @visibility("read")
  status?: string,

  @doc("List of steps of Edgedevice job.")
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

@doc("The deployment mode of edge device job.")
enum DeploymentMode {
  @doc("Validate edge device job.")
  Validate,
  @doc("Deploy edge device job.")
  Deploy
}

enum RemoteSupportAccessLevel{
    None,
    Diagnostics,
    DiagnosticsAndRepair
}

enum RemoteSupportType
{
    Enable,
    Revoke
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
@doc("Reported Properties for  job triggered from cloud.")
model JobReportedProperties {
  @doc("The percentage of the job that is complete.")
  @visibility("read")
  percentComplete?: int32,

  @doc("Validation status of job.")
  @visibility("read")
  validationStatus? : EceActionStatus,

  @doc("Deployment status of job.")
  @visibility("read")
  deploymentStatus? : EceActionStatus
}

@doc("Edge device type based on host OS installed.")
enum DeviceType{
    @doc("Arc-enabled edge device with HCI OS.")
    HCI,

    @doc("Arc-enabled edge device with WindowsServer OS.")
    WindowsServer,

    @doc("Arc-enabled edge device with WindowsIoT OS.")
    WindowsIoT,

    @doc("Arc-enabled edge device with AzureLinux OS.")
    AzureLinux,

    @doc("Arc-enabled edge device with UbuntuLinux OS.")
    UbuntuLinux
}

@doc("Common Job Types supported.")
enum EdgeDeviceJobType {
  @doc("CollectLog")
  CollectLog,

  @doc("RemoteSupport")
  RemoteSupport,

  @doc("RemoteConnect")
  RemoteConnect
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@doc("Jobs resource")
@parentResource(EdgeDevice)
@discriminator("kind")
model Job is ProxyResource<JobProperties> {
  @doc("Name of Job")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @segment("jobs")
  @key("jobsName")
  @path
  name: string,

  @doc("Edge Solution type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  kind: DeviceType
}

@doc("Edgedevice job properties")
model JobProperties {
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

  @doc("Status of Edgedevice job. Allowed values are 'Failed', 'Success', 'Running', 'canceled'")
  @visibility("read")
  status?: string,

  @doc("Reported properties for job")
  @visibility("read")
  reportedProperties?: JobReportedProperties
}

////////////////////////////////////////////////////////////////////////////////
////////Add JobProperties for common Edgedevice jobs///////
////////////////////////////////////////////////////////////////////////////////
model CollectLogJobProperties extends JobProperties{
  @doc("From date for log collection.")
  fromDate: utcDateTime,

  @doc("To date for log collection.")
  toDate: utcDateTime,  

  @doc("To date for log collection.")
  lastLogGenerated?: utcDateTime,

  @doc("log collection job reported properties.")
  reportedProperties?: LogCollectionReportedProperties
}

model LogCollectionReportedProperties{
  ... JobReportedProperties,

  logCollectionSessionDetails?: LogCollectionSession
}

model LogCollectionSession{
    startTime?: string, 
    endTime?: string,
    timeCollected?: string,
    logSize?: int32,
    status?: LogCollectionStatus, 
    correlationId?: string 
}

enum LogCollectionStatus
{
    None,
    InProgress,
    Failed,
    Succeeded
}


model RemoteSupportJobProperties extends JobProperties{

  @doc("Remote support access level.")
  accesslevel: RemoteSupportAccessLevel,

  @doc("Remote support expiration timestamp.")
  expirationTimeStamp: utcDateTime,

  @doc("Remote support type.")
  type: RemoteSupportType,

  @doc("log collection job reported properties.")
  reportedProperties?: RemoteSupportReportedProperties
}

model RemoteSupportReportedProperties{
  ... JobReportedProperties,
  nodeSettings?: RemoteSupportNodeSettings,
  SessionDetails?: RemoteSupportSession
}

model RemoteSupportNodeSettings{
  arcResourceId?: string,
  state?: string,
  createdAt?: utcDateTime,
  updatedAt?: utcDateTime,
  connectionStatus?: string,
  connectionErrorMessage?: string,
  transcriptLocation?: string
}

model RemoteSupportSession
{
    sessionStartTime?: utcDateTime,
    sessionEndTime?: utcDateTime,
    NodeName?: string,
    Duration?: int32,
    AccessLevel?: RemoteSupportAccessLevel
}

////////////////////////////////////////////////////////////////////////////////
////////end common jobs
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////define all AzureStack HCI jobs in below section///////
////////////////////////////////////////////////////////////////////////////////
@doc("Edgedevice job for Azure Stack HCI solution.")
model HciEdgeDeviceJob extends Job{
  kind: DeviceType.HCI,
  properties: HciEdgeDeviceJobProperties
}

@discriminator("jobType") 
@doc("HCI Edgedevice job properties")
model HciEdgeDeviceJobProperties extends JobProperties {
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: HciEdgeDeviceJobType
}

@doc("Job Type supported.")
enum HciEdgeDeviceJobType {
  //inherit common jobs
          ...EdgeDeviceJobType,

  // add HCI specific jobs
  @doc("RenameHostname")
  RenameHostname,

 
}

model HciCollectLogJobProperties extends HciEdgeDeviceJobProperties{
  ...CollectLogJobProperties,
  @doc("Collect Log Job Type.")
  jobType: HciEdgeDeviceJobType.CollectLog
}

model HciRemoteSupportJobProperties extends HciEdgeDeviceJobProperties{
  ...RemoteSupportJobProperties,
  @doc("Remote Support Job Type.")
  jobType: HciEdgeDeviceJobType.RemoteSupport
}

model HciRemoteConnectJobProperties extends HciEdgeDeviceJobProperties{
  @doc("Remote connect Job Type.")
  jobType: HciEdgeDeviceJobType.RemoteConnect,

  @doc("user name.")
  userName: string,

  @doc("password.")
  @secret
  password: string,
}
////////end AzureStack HCI jobs///////
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
////////Start AzureLinux jobs///////
////////////////////////////////////////////////////////////////////////////////
@doc("Edgedevice job for Azure Linux solution.")
model AzureLinuxEdgeDeviceJob extends Job{
  kind: DeviceType.AzureLinux,
  properties: AzureLinuxEdgeDeviceJobProperties
}

@doc("Job Type supported.")
enum AzureLinuxEdgeDeviceJobType  {
    // inherit common jobs
          ...EdgeDeviceJobType,

    //define Azure Linux specific job types
    @doc("EnableSsh")
    EnableSsh
}

@discriminator("jobType") 
@doc("Edgedevice job properties")
model AzureLinuxEdgeDeviceJobProperties extends JobProperties {
  @doc("Job Type to support polymorphic resource.")
  @extension("x-ms-mutability", ["create", "read"])
  jobType: AzureLinuxEdgeDeviceJobType
}

model AzureLinuxCollectLogJobProperties extends AzureLinuxEdgeDeviceJobProperties{
  ...CollectLogJobProperties,
  @doc("Collect Log Job Type.")
  jobType: AzureLinuxEdgeDeviceJobType.CollectLog
}

model AzureLinuxRemoteSupportJobProperties extends AzureLinuxEdgeDeviceJobProperties{
  ...RemoteSupportJobProperties,
  @doc("Remote Support Job Type.")
  jobType: AzureLinuxEdgeDeviceJobType.RemoteSupport
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