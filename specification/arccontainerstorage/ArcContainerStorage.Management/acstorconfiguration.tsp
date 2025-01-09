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

@doc("AcStorConfiguration is a custom resource that defines the configuration for a storage system.")
model AcStorConfiguration is ExtensionResource<AcStorConfigurationProperties> {
  @doc("The name of the AcStorConfiguration resource, which is always 'acstor-configuration' to enforce singleton.")
  @key("acstorConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("acstorconfigurations")
  @pattern("^acstor-configuration$") // Enforcing the singleton name pattern
  name: string;
}

// Define the properties for the AcStorConfiguration
@doc("Defines the properties of the AcStorConfiguration resource.")
model AcStorConfigurationProperties {
  @doc("The mount point for the disk.")
  @visibility("read")
  diskMountPoint: string = "/mnt"; // Default value is "/mnt"

  @doc("The capacity of the disk, including storage unit (e.g., 60Gi).")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  @visibility("read")
  diskCapacity: string;

  @doc("Configuration for creating a storage pool.")
  @visibility("read")
  createStoragePool: StoragePoolConfig;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState;
}

// Define the storage pool configuration
@doc("Defines the configuration for creating a storage pool.")
model StoragePoolConfig {
  @doc("Whether to create a storage pool.")
  enabled: boolean = true; // Default value is true

  @doc("The number of replicas to create.")
  @minValue(1) // Minimum value constraint
  @maxValue(10) // Maximum value constraint
  replicas: int32 = 3; // Default value is 3

  @doc("The name of the storage pool.")
  name: string = "arccontainerstorage-storage-pool"; // Default name

  @doc("The storage engine to use.")
  engineType: EngineTypes = EngineTypes.xfs; // Default value is "xfs"
}

@doc("EngineTypes")
union EngineTypes {
  @doc("xfs")
  xfs: "xfs",

  @doc("spaces")
  spaces: "spaces",

  string,
}

// Define the status properties for the AcStorConfiguration
@doc("Defines the observed status of the AcStorConfiguration resource.")
model AcStorConfigurationStatus {
  @doc("The current state of the configuration.")
  state: string;

  @doc("Additional details about the configuration's status.")
  details: string;
}

// Define the operations for the AcStorConfiguration resource
@armResourceOperations
interface AcStorConfigurations {
  get is ArmResourceRead<AcStorConfiguration>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<AcStorConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<AcStorConfiguration>;
  listByResourceGroup is ArmResourceListByParent<AcStorConfiguration>;
}
