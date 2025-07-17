import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";
import "./edgevolume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.ArcContainerStorage;

//    generation: "2"

/**
 * IngestSubvolume is a custom resource that defines configuration
 * for an edge subvolume in the Arc Container Storage system.
 */
@doc("IngestSubvolume is a custom resource that defines the configuration for a subvolume.")
@parentResource(EdgeVolume)
model IngestSubvolume is ProxyResource<IngestSubvolumeProperties> {
  ...ResourceNameParameter<
    IngestSubvolume,
    NamePattern = "^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$"
  >;
}

/**
 * Defines the properties for the IngestSubvolume resource.
 */
@doc("Defines the properties of the IngestSubvolume resource.")
model IngestSubvolumeProperties {
  @doc("Type of the subvolume.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  subvolumeType?: SubvolumeType;

  @doc("Top-level path for this subvolume (e.g., /mysubvol).")
  @minLength(1)
  @maxLength(255)
  path?: string;

  @doc("EdgeIngestPolicy used by this subvolume.")
  @minLength(1)
  @maxLength(253)
  ingestPolicy?: string;

  @doc("Authentication config for certain subvolumes.")
  auth?: AuthConfig;

  @doc("Blob storage endpoint, for example: https://mysa.core.windows.net")
  @minLength(3)
  @maxLength(1024)
  storageaccountendpoint?: string;

  @doc("Blob container name.")
  @minLength(3)
  container?: string;

  @doc("Optional Unix-like ownership info (UID/GID) for the subvolume.")
  authSys?: AuthSysConfig;

  @doc("Ingest configuration for the subvolume.")
  ingest?: IngestSubvolumeIngestConfig;

  @doc("Eviction configuration for the subvolume.")
  eviction?: IngestSubvolumeEvictionConfig;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: IngestSubvolumeStatus;
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

@doc("The ingest configuration for the subvolume.")
model IngestSubvolumeIngestConfig {
  @doc("The order in which dirty files will be uploaded - this is best effort, not a guarantee.")
  order?: IngestOrder;

  @doc("The minimum number of seconds before a dirty file is eligible for ingest.")
  @minValue(0)
  @maxValue(31536000)
  minDelaySec?: int32;
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

@doc("The eviction configuration for the subvolume.")
model IngestSubvolumeEvictionConfig {
  @doc("The order in which clean files will be evicted - this is best effort, not a guarantee.")
  order?: EvictionOrder;

  @doc("The minimum number of seconds before a clean file is eligible for eviction.")
  @minValue(0)
  @maxValue(31536000)
  minDelaySec?: int32;
}

/**
 * Enum describing the type of subvolume.
 */
@doc("Type of the subvolume.")
union SubvolumeType {
  @doc("Data ingestion subvolume.")
  INGEST: "INGEST",

  @doc("Mirror subvolume for replication.")
  MIRROR: "MIRROR",

  string,
}

/**
 * Authentication config used if 'path != /' or certain authentication is required.
 */
@doc("Authentication settings for secure access to storage.")
model AuthConfig {
  @doc("Auth method to use.")
  authType: AuthType; // this is required

  //"!(self.authType in ['SAS', 'KEY', 'CONNECTION_STRING']) || (has(self.secretName) && has(self.secretNamespace))"

  @doc("Name of the K8s secret storing credentials. Required for SAS/KEY/CONNECTION_STRING.")
  secretName?: string;

  @doc("Namespace of the K8s secret storing credentials.")
  secretNamespace?: string;
}

/**
 * AuthType enumerates possible authentication methods.
 */
@doc("Possible authentication methods.")
union AuthType {
  @doc("SAS token for authentication (not recommended)")
  SAS: "SAS",

  @doc("Key for authentication (not recommended)")
  KEY: "KEY",

  @doc("Connection String for authentication (not recommended)")
  CONNECTION_STRING: "CONNECTION_STRING",

  @doc("Workload Identity for authentication.")
  WORKLOAD_IDENTITY: "WORKLOAD_IDENTITY",

  @doc("Managed Identity for authentication.")
  MANAGED_IDENTITY: "MANAGED_IDENTITY",

  string,
}

/**
 * UID/GID ownership for the subvolume.
 */
@doc("Unix-like ownership of the subvolume via UID/GID.")
model AuthSysConfig {
  @doc("User ID owning the subvolume (default 4294967294).")
  @minValue(1) // Minimum value constraint
  @maxValue(4294967294) // Maximum value constraint
  uid: int64; // Required

  @doc("Group ID owning the subvolume (default 4294967294).")
  @minValue(1) // Minimum value constraint
  @maxValue(4294967294) // Maximum value constraint
  gid: int64; // Required
}

/**
 * Defines the observed status of the IngestSubvolume resource.
 */
@doc("Defines the observed status of the IngestSubvolume resource.")
model IngestSubvolumeStatus {
  @doc("The current state of the subvolume.")
  state?: string;

  @doc("A reference to the EdgeVolume resource.")
  edgeVolumeRef?: string;

  @doc("Describes the backend connection.")
  backendConnection?: string;

  @doc("The connected storage account endpoint in use.")
  connectedStorageAccountEndpoint?: string;

  @doc("The connected container in use.")
  connectedContainer?: string;
}

/**
 * FileError describes a file-level error in the subvolume.
 */
@doc("File error model for tracking errors on individual files.")
model FileError {
  @doc("The name of the file that encountered the error.")
  fileName?: string;

  @doc("A timestamp (or date string) indicating when this error was last observed.")
  lastSeen?: string;

  @doc("A human-readable description of the error.")
  error?: string;

  @doc("An optional integer code or identifier related to the error.")
  export?: int32;
}

/**
 * Resource operations for the IngestSubvolume resource.
 */
@armResourceOperations
interface IngestSubvolumes {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<IngestSubvolume>;
  delete is ArmResourceDeleteWithoutOkAsync<IngestSubvolume>;
  get is ArmResourceRead<IngestSubvolume>;
  list is ArmResourceListByParent<IngestSubvolume>;
  update is ArmResourcePatchAsync<IngestSubvolume, IngestSubvolumeProperties>;
}
