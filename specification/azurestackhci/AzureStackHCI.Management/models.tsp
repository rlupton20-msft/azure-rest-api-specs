import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.AzureStackHCI;

enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned, UserAssigned`,
}

enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Accepted,
  Provisioning,
  NotSpecified,
  Creating,
  Updating,
  Deleting,
  Moving,
  Deleted,
  PartiallySucceeded,
  InProgress,
  DisableInProgress,
  Connected,
  PartiallyConnected,
  Disconnected,
}

enum Status {
  NotYetRegistered,
  ConnectedRecently,
  NotConnectedRecently,
  Disconnected,
  Error,
  NotSpecified,
}

enum SoftwareAssuranceStatus {
  Enabled,
  Disabled,
}

enum SoftwareAssuranceIntent {
  Enable,
  Disable,
}

enum WindowsServerSubscription {
  Disabled,
  Enabled,
}

enum DiagnosticLevel {
  Off,
  Basic,
  Enhanced,
}

enum ClusterNodeType {
  FirstParty,
  ThirdParty,
}

enum ImdsAttestation {
  Disabled,
  Enabled,
}

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("List of clusters.")
model ClusterList is Azure.Core.Page<Cluster>;

@doc("Cluster details.")
model Cluster {
  ...TrackedResource;

  @doc("Identity of Cluster resource")
  identity?: ManagedServiceIdentity;

  @doc("Cluster properties.")
  properties?: ClusterProperties;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model ManagedServiceIdentity {
  @doc("""
The service principal ID of the system assigned identity. This property will
only be provided for a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant ID of the system assigned identity. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("""
Type of managed service identity (where both SystemAssigned and UserAssigned
types are allowed).
""")
  type: ManagedServiceIdentityType;

  @doc("""
The set of user assigned identities associated with the resource. The
userAssignedIdentities dictionary keys will be ARM resource ids in the form:
'/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}.
The dictionary values can be empty objects ({}) in requests.
""")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("User assigned identity properties")
model UserAssignedIdentity {
  @doc("The principal ID of the assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The client ID of the assigned identity.")
  @visibility("read")
  clientId?: string;
}

@doc("Cluster properties.")
model ClusterProperties {
  @doc("Provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Status of the cluster agent.")
  @visibility("read")
  status?: Status;

  @doc("Unique, immutable resource id.")
  @visibility("read")
  cloudId?: string;

  @doc("Endpoint configured for management from the Azure portal.")
  cloudManagementEndpoint?: string;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Object id of cluster AAD identity.")
  aadApplicationObjectId?: string;

  @doc("Id of cluster identity service principal.")
  aadServicePrincipalObjectId?: string;

  @doc("Software Assurance properties of the cluster.")
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;

  @doc("Properties reported by cluster agent.")
  @visibility("read")
  reportedProperties?: ClusterReportedProperties;

  @doc("Number of days remaining in the trial period.")
  @visibility("read")
  trialDaysRemaining?: float32;

  @doc("Type of billing applied to the resource.")
  @visibility("read")
  billingModel?: string;

  @doc("First cluster sync timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTimestamp?: utcDateTime;

  @doc("Most recent cluster sync timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  @doc("Most recent billing meter timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBillingTimestamp?: utcDateTime;

  @doc("Region specific DataPath Endpoint of the cluster.")
  @visibility("read")
  serviceEndpoint?: string;

  @doc("Object id of RP Service Principal")
  @visibility("read")
  resourceProviderObjectId?: string;
}

@doc("Software Assurance properties of the cluster.")
model SoftwareAssuranceProperties {
  @doc("Status of the Software Assurance for the cluster.")
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  @doc("Customer Intent for Software Assurance Benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  @doc("TimeStamp denoting the latest SA benefit applicability is validated.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

@doc("Desired properties of the cluster.")
model ClusterDesiredProperties {
  @doc("Desired state of Windows Server Subscription.")
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Desired level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;
}

@doc("Properties reported by cluster agent.")
model ClusterReportedProperties {
  @doc("Name of the on-prem cluster connected to this resource.")
  @visibility("read")
  clusterName?: string;

  @doc("Unique id generated by the on-prem cluster.")
  @visibility("read")
  clusterId?: string;

  @doc("Version of the cluster software.")
  @visibility("read")
  clusterVersion?: string;

  @doc("List of nodes reported by the cluster.")
  @visibility("read")
  nodes?: ClusterNode[];

  @doc("Last time the cluster reported the data.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  @doc("IMDS attestation status of the cluster.")
  @visibility("read")
  imdsAttestation?: ImdsAttestation;

  @doc("Level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;

  @doc("Capabilities supported by the cluster.")
  @visibility("read")
  supportedCapabilities?: string[];

  @doc("The node type of all the nodes of the cluster.")
  @visibility("read")
  clusterType?: ClusterNodeType;

  @doc("The manufacturer of all the nodes of the cluster.")
  @visibility("read")
  manufacturer?: string;
}

@doc("Cluster node details.")
model ClusterNode {
  @doc("Name of the cluster node.")
  @visibility("read")
  name?: string;

  @doc("Id of the node in the cluster.")
  @visibility("read")
  id?: float32;

  @doc("State of Windows Server Subscription.")
  @visibility("read")
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Type of the cluster node hardware.")
  @visibility("read")
  nodeType?: ClusterNodeType;

  @doc("Edge Hardware Center Resource Id")
  @visibility("read")
  ehcResourceId?: string;

  @doc("Manufacturer of the cluster node hardware.")
  @visibility("read")
  manufacturer?: string;

  @doc("Model name of the cluster node hardware.")
  @visibility("read")
  `model`?: string;

  @doc("Operating system running on the cluster node.")
  @visibility("read")
  osName?: string;

  @doc("Version of the operating system running on the cluster node.")
  @visibility("read")
  osVersion?: string;

  @doc("Display version of the operating system running on the cluster node.")
  @visibility("read")
  osDisplayVersion?: string;

  @doc("Immutable id of the cluster node.")
  @visibility("read")
  serialNumber?: string;

  @doc("Number of physical cores on the cluster node.")
  @visibility("read")
  coreCount?: float32;

  @doc("Total available memory on the cluster node (in GiB).")
  @visibility("read")
  memoryInGiB?: float32;

  @doc("Most recent licensing timestamp.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLicensingTimestamp?: utcDateTime;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("Cluster details to update.")
model ClusterPatch {
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Identity of Cluster resource")
  identity?: ManagedServiceIdentity;

  @doc("Cluster properties.")
  properties?: ClusterPatchProperties;
}

@doc("Cluster properties.")
model ClusterPatchProperties {
  @doc("Endpoint configured for management from the Azure portal")
  cloudManagementEndpoint?: string;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;
}

model UploadCertificateRequest {
  properties?: RawCertificateData;
}

model RawCertificateData {
  certificates?: string[];
}

@doc("Cluster Identity details.")
model ClusterIdentityResponse {
  @doc("Cluster identity properties.")
  @visibility("read")
  properties?: ClusterIdentityResponseProperties;
}

model ClusterIdentityResponseProperties {
  aadClientId?: string;
  aadTenantId?: string;
  aadServicePrincipalObjectId?: string;
  aadApplicationObjectId?: string;
}

model SoftwareAssuranceChangeRequest {
  properties?: SoftwareAssuranceChangeRequestProperties;
}

model SoftwareAssuranceChangeRequestProperties {
  @doc("Customer Intent for Software Assurance Benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}
