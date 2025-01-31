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
 * SyncSubvolume is a custom resource that triggers or manages synchronization
 * for an EdgeSubvolume in the Arc Container Storage system.
 */
@doc("SyncSubvolume is a custom resource that defines the configuration for synchronizing an EdgeSubvolume.")
model SyncSubvolume is ExtensionResource<SyncSubvolumeProperties> {
  @doc("The name of the SyncSubvolume resource.")
  @key("syncSubvolumeName")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$")
  @path
  @segment("syncsubvolumes")
  name: string;
}

/**
 * Defines the 'spec' fields for the SyncSubvolume resource.
 */
@doc("Defines the properties (spec) of the SyncSubvolume resource.")
model SyncSubvolumeProperties {
  @doc("Name of the EdgeSubvolume to sync.")
  @minLength(1)
  @maxLength(255)
  @visibility("create", "read")
  edgesubvolume: string;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState | provisioningStateSyncSubVolume;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility("read")
  status?: SyncSubvolumeStatus;
}

@doc("Adding provisioning state for SyncSubVolume")
union provisioningStateSyncSubVolume {
  @doc("configuring")
  configuring: "configuring",

  @doc("cleaning_up")
  cleaning_up: "cleaning_up",

  @doc("completed")
  completed: "completed",

  string,
}

/**
 * Defines the observed status of the SyncSubvolume resource.
 */
@doc("Defines the observed status (status) of the SyncSubvolume resource.")
model SyncSubvolumeStatus {
  @doc("The current state of the SyncSubvolume. Defaults to 'unknown'.")
  state?: string = "unknown";

  @doc("Additional details about the SyncSubvolume status.")
  details?: string;

  @doc("Reference to the EdgeSubvolume being synchronized.")
  edgeSubvolumeRef?: string;
}

/**
 * CRUD operations for the SyncSubvolume resource.
 */
@armResourceOperations
interface SyncSubvolumes {
  get is ArmResourceRead<SyncSubvolume>;
  createOrReplace is ArmResourceCreateOrReplaceSync<SyncSubvolume>;
  delete is ArmResourceDeleteWithoutOkAsync<SyncSubvolume>;
  list is ArmResourceListByParent<SyncSubvolume>;
}
