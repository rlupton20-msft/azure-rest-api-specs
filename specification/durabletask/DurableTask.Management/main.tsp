import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.DurableTask" })
@versioned(Versions)
namespace Microsoft.DurableTask;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-10-01-preview")
  v2024_10_01_Preview: "2024-10-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-04-01-preview")
  v2025_04_01_Preview: "2025-04-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-05-04-preview")
  v2025_05_04_Preview: "2025-05-04-preview",
}

@doc("A Durable Task Scheduler resource")
@added(Versions.v2024_10_01_Preview)
model Scheduler is Azure.ResourceManager.TrackedResource<SchedulerProperties> {
  ...ResourceNameParameter<
    Scheduler,
    "schedulerName",
    "schedulers",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("Details of the Scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist: string[];

  @doc("SKU of the durable task scheduler")
  sku: SchedulerSku;

  /** The private endpoints exposed by this resource */
  @added(Versions.v2025_05_04_Preview)
  @visibility(Lifecycle.Read)
  endpoints?: PrivateEndpoint[];
}

/** Holder for private endpoint connections */
@added(Versions.v2025_05_04_Preview)
@parentResource(Scheduler)
model PrivateEndpointConnectionResource
  is ProxyResource<PrivateEndpointConnectionProperties> {
  ...PrivateEndpointConnectionParameter;
}

/** Private connection operations */
@added(Versions.v2025_05_04_Preview)
@armResourceOperations(PrivateEndpointConnectionResource)
interface PrivateEndpointConnections {
  /** List existing private connections */
  listByTestTrackedResource is ArmResourceListByParent<PrivateEndpointConnectionResource>;
  /** Get a specific private connection */
  get is ArmResourceRead<PrivateEndpointConnectionResource>;
  /** Create a Private endpoint connection */
  create is ArmResourceCreateOrReplaceSync<PrivateEndpointConnectionResource>;
  /** Delete the private endpoint connection */
  delete is ArmResourceDeleteSync<PrivateEndpointConnectionResource>;
}

/** Private Links for TestRackedResource */
// #suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Expected for private links"
@added(Versions.v2025_05_04_Preview)
@parentResource(Scheduler)
model PrivateLinkResource is ProxyResource<PrivateLinkResourceProperties> {
  ...PrivateLinkResourceParameter;
}

@doc("The SKU (Stock Keeping Unit) assigned to this durable task scheduler")
@added(Versions.v2024_10_01_Preview)
model SchedulerSku {
  @doc("The name of the SKU")
  name: string;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@doc("A Task Hub resource belonging to the scheduler")
@added(Versions.v2024_10_01_Preview)
@parentResource(Scheduler)
model TaskHub is Azure.ResourceManager.ProxyResource<TaskHubProperties> {
  ...ResourceNameParameter<
    TaskHub,
    "taskHubName",
    "taskHubs",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("A retention policy resource belonging to the scheduler")
@added(Versions.v2025_04_01_Preview)
@parentResource(Scheduler)
model RetentionPolicy
  is Azure.ResourceManager.ProxyResource<RetentionPolicyProperties> {
  ...ResourceNameParameter<
    RetentionPolicy,
    "retentionPolicyName",
    "retentionPolicies",
    "^[a-zA-Z0-9-]{3,64}$"
  >;
}

@doc("The properties of a retention policy")
@added(Versions.v2025_04_01_Preview)
model RetentionPolicyProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("The retention period in days after which the orchestration state will be purged automatically")
  retentionPeriodInDays: int32;

  @doc("The orchestration state to which this policy applies")
  orchestrationState: PurgeableOrchestrationState;
}

@doc("Purgeable Orchestration State to be used in retention policies")
union PurgeableOrchestrationState {
  string,

  @doc("Any purgeable orchestration state")
  Any: "*",

  @doc("The orchestration is completed")
  Completed: "Completed",

  @doc("The orchestration is failed")
  Failed: "Failed",

  @doc("The orchestration is terminated")
  Terminated: "Terminated",

  @doc("The orchestration is terminated")
  Canceled: "Canceled",
}

@doc("The state of the resource redundancy")
@added(Versions.v2024_10_01_Preview)
union RedundancyState {
  string,

  @doc("The resource is not redundant")
  None: "None",

  @doc("The resource is zone redundant")
  Zone: "Zone",
}

@doc("The properties of Task Hub")
@added(Versions.v2024_10_01_Preview)
model TaskHubProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler dashboard")
  @visibility(Lifecycle.Read)
  dashboardUrl?: url;
}

@doc("The status of the current operation")
@added(Versions.v2024_10_01_Preview)
@Azure.Core.lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}

@doc("The update request model for the Scheduler resource")
@added(Versions.v2024_10_01_Preview)
model SchedulerUpdate
  is UpdateableProperties<Azure.ResourceManager.TrackedResource<SchedulerPropertiesUpdate>>;

@doc("The Scheduler resource properties to be updated")
@added(Versions.v2024_10_01_Preview)
model SchedulerPropertiesUpdate {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation")
  provisioningState?: ProvisioningState;

  @doc("URL of the durable task scheduler")
  @visibility(Lifecycle.Read)
  endpoint?: string;

  @doc("IP allow list for durable task scheduler. Values can be IPv4, IPv6 or CIDR")
  ipAllowlist?: string[];

  @doc("SKU of the durable task scheduler")
  sku?: SchedulerSkuUpdate;
}

@doc("The SKU (Stock Keeping Unit) properties to be updated")
@added(Versions.v2024_10_01_Preview)
model SchedulerSkuUpdate {
  @doc("The name of the SKU")
  name?: string;

  @doc("The SKU capacity. This allows scale out/in for the resource and impacts zone redundancy")
  capacity?: int32;

  @doc("Indicates whether the current SKU configuration is zone redundant")
  @visibility(Lifecycle.Read)
  redundancyState?: RedundancyState;
}

@added(Versions.v2024_10_01_Preview)
@armResourceOperations(Scheduler)
interface Schedulers {
  @doc("Get a Scheduler")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<Scheduler>;
  @doc("Create or replace a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Scheduler>;
  @doc("Update a Scheduler")
  @errorsDoc("Validation error: required parameters are missing")
  update is ArmCustomPatchAsync<Scheduler, SchedulerUpdate>;
  @doc("Delete a Scheduler")
  delete is ArmResourceDeleteWithoutOkAsync<Scheduler>;
  @doc("List Schedulers by resource group")
  listByResourceGroup is ArmResourceListByParent<Scheduler>;
  @doc("List Schedulers by subscription")
  listBySubscription is ArmListBySubscription<Scheduler>;
}

@added(Versions.v2024_10_01_Preview)
@armResourceOperations(TaskHub)
interface TaskHubs {
  @doc("Get a Task Hub")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<TaskHub>;
  @doc("Create or Update a Task Hub")
  @errorsDoc("Validation error: required parameters are missing")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TaskHub>;
  @doc("Delete a Task Hub")
  delete is ArmResourceDeleteWithoutOkAsync<TaskHub>;
  @doc("List Task Hubs")
  listByScheduler is ArmResourceListByParent<TaskHub>;
}

@added(Versions.v2025_04_01_Preview)
@armResourceOperations(RetentionPolicy)
interface RetentionPolicies {
  @doc("Get a Retention Policy")
  @errorsDoc("Not found error: resource does not exist")
  get is ArmResourceRead<RetentionPolicy>;
  @doc("Create or Update a Retention Policy")
  @errorsDoc("Validation error: required parameters are missing")
  createOrReplace is ArmResourceCreateOrReplaceAsync<RetentionPolicy>;
  @doc("Delete a Retention Policy")
  delete is ArmResourceDeleteWithoutOkAsync<RetentionPolicy>;
  @doc("List Retention Policies")
  listByScheduler is ArmResourceListByParent<RetentionPolicy>;
}

/** Operations for private links on TestTrackedResource */
@added(Versions.v2025_05_04_Preview)
@armResourceOperations(PrivateLinkResource)
interface PrivateLinks {
  /** list private links on the given resource */
  listByTestTrackedResource is ArmResourceListByParent<PrivateLinkResource>;
}
