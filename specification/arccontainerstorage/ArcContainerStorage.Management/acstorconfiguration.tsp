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

//    generation: "6"
@doc("AcStorConfiguration defines the configuration for a storage system. It is a singleton which must be named 'acstor-configuration'.")
model AcStorConfiguration
  is ExtensionResource<
    AcStorConfigurationProperties,
    PropertiesOptional = false
  > {
  ...ResourceNameParameter<
    AcStorConfiguration,
    NamePattern = "^acstor-configuration$"
  >;
}

// Define the properties for the AcStorConfiguration
@doc("Defines the properties of the AcStorConfiguration resource.")
model AcStorConfigurationProperties {
  @doc("The mount point for the disk.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  diskMountPoint?: string = "/mnt"; // Default value is "/mnt"

  @doc("The capacity of the disk, including storage unit (e.g., 60Gi).")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  diskCapacity: string; //TODO: check later if this is optional

  @doc("The linux IO interface to use.")
  ioInterface?: IoInterfaces = IoInterfaces.uring;

  @doc("Configuration for creating a storage pool.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  createStoragePool?: StoragePoolConfig;

  @doc("io engine cpu limit")
  @pattern("^([0-9]+m?|0[.][0-9]+)?$")
  ioEngineCpuLimit?: string = "2000m";

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: provisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: AcStorConfigurationStatus;
}

// Define the storage pool configuration
@doc("Defines the configuration for creating a storage pool.")
model StoragePoolConfig {
  @doc("Whether to create a storage pool.")
  enabled?: boolean = true; // Default value is true

  @doc("The number of replicas to create.")
  @minValue(1) // Minimum value constraint
  @maxValue(128) // Maximum value constraint
  replicas?: int32 = 3; // Default value is 3

  @doc("The name of the storage pool.")
  name?: string = "arccontainerstorage-storage-pool"; // Default name

  // We need a liquid transform for this
  @doc("The storage engine to use.")
  engineType?: EngineTypes = EngineTypes.xfs; // Default value is "xfs"

  @doc("The type of disk to use.")
  diskType?: DiskTypes = DiskTypes.temp;
}

@doc("Linux io interfaces used for disk operations.")
union IoInterfaces {
  @doc("io_uring - recommended for most kernels")
  uring: "uring",

  @doc("aio - required for openshift")
  aio: "aio",

  string,
}

@doc("EngineTypes used for storage pool.")
union EngineTypes {
  @doc("use the extension default.")
  default: "default",

  @doc("xfs will be used for the storage pool.")
  xfs: "xfs",

  @doc("spaces will be used for the storage pool.")
  spaces: "spaces",

  string,
}

@doc("Disk types used for storage pool.")
union DiskTypes {
  @doc("nvme will be used for the storage pool.")
  nvme: "nvme",

  @doc("temp disk will be used for the storage pool.")
  temp: "temp",

  string,
}

// Define the status properties for the AcStorConfiguration
@doc("Defines the observed status of the AcStorConfiguration resource.")
model AcStorConfigurationStatus {
  @doc("The current state of the configuration.")
  state?: string;

  @doc("Additional details about the configuration's status.")
  details?: string;
}

// Define the operations for the AcStorConfiguration resource
@armResourceOperations
interface AcStorConfigurations {
  get is ArmResourceRead<AcStorConfiguration>;
  createOrReplace is ArmResourceCreateOrReplaceSync<AcStorConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<AcStorConfiguration>;
  list is ArmResourceListByParent<AcStorConfiguration>;
}
