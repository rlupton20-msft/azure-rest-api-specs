import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp"; // Import provisioningState model

using Azure.ResourceManager;

namespace Private.ArcContainerStorage;

// generation: "3"

@doc("EdgeIngestPolicy is a custom resource that defines the configuration for edge ingest policies.")
model EdgeIngestPolicy is ExtensionResource<EdgeIngestPolicyProperties> {
  ...ResourceNameParameter<
    EdgeIngestPolicy,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-\\.]+[a-zA-Z0-9]$"
  >;
}

// Define the properties for the EdgeIngestPolicy
@doc("Defines the properties of the EdgeIngestPolicy resource.")
model EdgeIngestPolicyProperties {
  @doc("Defines the configuration for ingest policies.")
  ingest?: IngestConfig;

  @doc("Defines the configuration for eviction policies.")
  eviction?: EvictionConfig;

  //"Defines the action to take on any linked EdgeSubVolumes that are requested to be deleted.")
  @doc("Possible values: trigger-immediate-ingest or abandon. Can be extended to other string values.")
  onDelete?: OnDeleteAction;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState; // Referencing the provisioningState union

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: EdgeIngestPolicyStatus;
}

// Define the open enum for onDelete
@doc("Defines the possible actions for linked EdgeSubVolumes on delete.")
union OnDeleteAction {
  @doc("Trigger immediate ingestion for linked EdgeSubVolumes.")
  `trigger-immediate-ingest`: "trigger-immediate-ingest",

  @doc("Abandon linked EdgeSubVolumes without any action.")
  abandon: "abandon",

  @doc("Any other string value is allowed as a custom action.")
  string, // Open enum allows any other string value
}

// Define the open enum for ingest order
@doc("Defines the possible order for dirty file ingestion.")
union IngestOrder {
  @doc("Upload dirty files in the order of oldest first.")
  `oldest-first`: "oldest-first",

  @doc("Upload dirty files in the order of newest first.")
  `newest-first`: "newest-first",

  @doc("Any other string value is allowed as a custom order.")
  string, // Open enum allows any other string value
}

// Define the open enum for eviction order
@doc("Defines the possible order for clean file eviction.")
union EvictionOrder {
  @doc("Do not evict any files.")
  `never`: "never",

  @doc("Evict files in an unordered manner.")
  unordered: "unordered",

  @doc("Any other string value is allowed as a custom order.")
  string, // Open enum allows any other string value
}

// Define the ingest configuration
@doc("Defines the configuration for ingest policies.")
model IngestConfig {
  @doc("The order in which dirty files will be uploaded.")
  order?: IngestOrder;

  @doc("The minimum number of seconds before a dirty file is eligible for ingest.")
  @minValue(0)
  @maxValue(31536000)
  minDelaySec?: int32;
}

// Define the eviction configuration
@doc("Defines the configuration for eviction policies.")
model EvictionConfig {
  @doc("The order in which clean files will be evicted.")
  order?: EvictionOrder;

  @doc("The number of seconds before a clean file is eligible for eviction.")
  @minValue(0) // Minimum value constraint
  @maxValue(31536000) // Maximum value constraint
  minDelaySec?: int32;
}

// Define the status properties for the EdgeIngestPolicy
@doc("Defines the observed status of the EdgeIngestPolicy resource.")
model EdgeIngestPolicyStatus {
  @doc("The current state of the policy.")
  state?: string;

  @doc("Additional details about the policy's status.")
  details?: string;

  @doc("Provisioning status of the resource.")
  provisioningStatus?: ProvisioningStatus;
}

// Define the operations for the EdgeIngestPolicy resource
@armResourceOperations
interface EdgeIngestPolicies {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EdgeIngestPolicy>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeIngestPolicy>;
  get is ArmResourceRead<EdgeIngestPolicy>;
  list is ArmResourceListByParent<EdgeIngestPolicy>;
  update is ArmResourcePatchAsync<EdgeIngestPolicy, EdgeIngestPolicyProperties>;
}
