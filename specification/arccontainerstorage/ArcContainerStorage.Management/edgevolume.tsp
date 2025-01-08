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
 * EdgeVolume is a custom resource that defines the configuration for edge volume storage.
 */
@doc("EdgeVolume is a custom resource for defining an edge volume.")
model EdgeVolume is ExtensionResource<EdgeVolumeProperties> {
  @doc("The name of the EdgeVolume resource.")
  @key("edgeVolumeName")
  @pattern("^[a-zA-Z0-9]([a-zA-Z0-9-_.]*[a-zA-Z0-9])?$")
  @path
  @segment("edgevolumes")
  name: string;
}

/**
 * Defines the properties for the EdgeVolume resource (similar to 'spec' in the CRD).
 */
@doc("Defines the desired state (spec) of the EdgeVolume resource.")
model EdgeVolumeProperties {
  @doc("Size of the EdgeVolume (example: 1Gi). Must be a valid storage size and is immutable once set.")
  requestedSize: string;

  @doc("Weight of concurrency for ingest operations (between 1 and 256).")
  @minValue(1) // Minimum value constraint
  @maxValue(256) // Maximum value constraint
  ingestOperationConcurrency?: int32;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState;
}

/**
 * Defines the observed status of the EdgeVolume resource.
 */
@doc("Defines the observed state (status) of the EdgeVolume resource.")
model EdgeVolumeStatus {
  @doc("The current state of the EdgeVolume. Defaults to 'unknown'.")
  state?: string = "unknown";

  @doc("Additional details about the EdgeVolume status.")
  details?: string;

  @doc("The amount of space available (string format, e.g., '500Mi').")
  spaceAvailable?: string;

  @doc("A reference to the underlying persistent volume.")
  persistentVolume?: string;

  @doc("List of subvolumes (by name or ID) that have encountered errors.")
  subvolumesWithErrors?: string[];
}

/**
 * CRUD operations for the EdgeVolume resource.
 */
@armResourceOperations
interface EdgeVolumes {
  get is ArmResourceRead<EdgeVolume>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<EdgeVolume>;
  delete is ArmResourceDeleteWithoutOkAsync<EdgeVolume>;
  listByResourceGroup is ArmResourceListByParent<EdgeVolume>;
}
