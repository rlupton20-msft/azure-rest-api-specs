import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.ArcContainerStorage;

/**
 * EdgeSubvolume is a custom resource that defines configuration
 * for an edge subvolume in the Arc Container Storage system.
 */
@doc("EdgeSubvolume is a custom resource that defines the configuration for a subvolume.")
model EdgeSubvolume is ExtensionResource<EdgeSubvolumeProperties> {
  @doc("The name of the EdgeSubvolume resource.")
  @key("edgeSubvolumeName")
  @segment("edgesubvolumes")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$")
  @path
  name: string;
}

/**
 * Defines the properties for the EdgeSubvolume resource.
 */
@doc("Defines the properties of the EdgeSubvolume resource.")
model EdgeSubvolumeProperties {
  @doc("Type of the subvolume.")
  @visibility("read")
  subvolumeType?: SubvolumeType = SubvolumeType.INGEST;

  @doc("Name of the EdgeVolume that this subvolume references.")
  @minLength(1)
  @maxLength(255)
  edgevolume: string;

  @doc("Top-level path for this subvolume (e.g., /mysubvol).")
  @minLength(1)
  @maxLength(255)
  // pattern ^/?[a-zA-Z0-9-\\._]*$
  path: string;

  @doc("EdgeIngestPolicy used by this subvolume.")
  @minLength(1)
  @maxLength(253)
  // pattern ^[a-zA-Z0-9][a-zA-Z0-9-\\.]+[a-zA-Z0-9]$
  ingestPolicy: string = "edgeingestpolicy-default";

  @doc("Optional authentication config for certain subvolumes.")
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

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState;
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
  authType?: AuthType;

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
  @doc("SAS")
  SAS: "SAS",

  @doc("Key")
  KEY: "KEY",

  @doc("Connection String")
  CONNECTION_STRING: "CONNECTION_STRING",

  @doc("Workload Identity")
  WORKLOAD_IDENTITY: "WORKLOAD_IDENTITY",

  @doc("Managed Identity")
  MANAGED_IDENTITY: "MANAGED_IDENTITY",

  string,
}

/**
 * UID/GID ownership for the subvolume.
 */
@doc("Unix-like ownership of the subvolume via UID/GID.")
model AuthSysConfig {
  @doc("User ID owning the subvolume (default 4294967294).")
  uid?: int64;

  @doc("Group ID owning the subvolume (default 4294967294).")
  gid?: int64;
}

/**
 * Defines the observed status of the EdgeSubvolume resource.
 */
@doc("Defines the observed status of the EdgeSubvolume resource.")
model EdgeSubvolumeStatus {
  @doc("The current state of the subvolume. Defaults to 'unknown'.")
  state?: string = "unknown";

  @doc("Last config error message.")
  lastConfigError?: string;

  @doc("A reference to the EdgeVolume resource.")
  edgeVolumeRef?: string;

  @doc("Number of files left to upload.")
  @minValue(0) // Minimum value constraint
  @maxValue(1000) // Maximum value constraint
  numberFilesLeftToUpload?: int32;

  @doc("Describes the backend connection.")
  backendConnection?: string;

  @doc("The subvolume requested for sync.")
  requestedSyncSubvolume?: string;

  @doc("The current running sync state.")
  runningSync?: string;

  @doc("The connected storage account endpoint in use.")
  connectedStorageAccountEndpoint?: string;

  @doc("The connected container in use.")
  connectedContainer?: string;

  @doc("List of file errors encountered.")
  @OpenAPI.extension("x-ms-identifiers", [])
  fileErrors?: FileError[];

  @doc("Total count of file errors.")
  @minValue(0) // Minimum value constraint
  @maxValue(1000) // Maximum value constraint
  totalFileErrors?: int32;
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
  @minValue(0) // Minimum value constraint
  @maxValue(10) // Maximum value constraint
  export?: int32;
}

/**
 * Resource operations for the EdgeSubvolume resource.
 */
@armResourceOperations
interface EdgeSubvolumes {
  get is ArmResourceRead<EdgeSubvolume>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<EdgeSubvolume>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeSubvolume>;
  listByResourceGroup is ArmResourceListByParent<EdgeSubvolume>;
}
