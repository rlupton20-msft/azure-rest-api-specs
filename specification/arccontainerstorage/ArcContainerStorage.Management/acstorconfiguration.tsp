import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.ArcContainerStorage;

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@doc("ACStorConfiguration is a custom resource that defines the configuration for a storage system.")
model ACStorConfiguration is ExtensionResource<ACStorConfigurationProperties> {
  @doc("The name of the ACStorConfiguration resource, which is always 'acstor-configuration' to enforce singleton.")
  @key("acstorConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("acstorconfigurations")
  @pattern("^acstor-configuration$") // Enforcing the singleton name pattern
  name: string;
}

// Define the properties for the ACStorConfiguration
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@doc("Defines the properties of the ACStorConfiguration resource.")
model ACStorConfigurationProperties {
  @doc("The mount point for the disk.")
  diskMountPoint: string = "/mnt"; // Default value is "/mnt"

  @doc("The capacity of the disk, including storage unit (e.g., 60Gi).")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  diskCapacity: string;

  @doc("Configuration for creating a storage pool.")
  createStoragePool: StoragePoolConfig;

  @doc("The provisioning state of the resource.")
  @visibility("read")
  provisioningState?: provisioningState;
}

@doc("provisioningState")
union provisioningState {
  @doc("Succeeded")
  Succeeded: "Succeeded",

  @doc("Failed")
  Failed: "Failed",

  @doc("Canceled")
  Canceled: "Canceled",

  string,
}

// Define the storage pool configuration
@doc("Defines the configuration for creating a storage pool.")
model StoragePoolConfig {
  @doc("Whether to create a storage pool.")
  enabled: boolean = true; // Default value is true

  @doc("The number of replicas to create.")
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

// Define the status properties for the ACStorConfiguration
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@doc("Defines the observed status of the ACStorConfiguration resource.")
model ACStorConfigurationStatus {
  @doc("The current state of the configuration.")
  state: string;

  @doc("Additional details about the configuration's status.")
  details: string;
}

// Define the operations for the ACStorConfiguration resource
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
@armResourceOperations
interface ACStorConfigurations {
  get is ArmResourceRead<ACStorConfiguration>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<ACStorConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<ACStorConfiguration>;
  listByResourceGroup is ArmResourceListByParent<ACStorConfiguration>;
}