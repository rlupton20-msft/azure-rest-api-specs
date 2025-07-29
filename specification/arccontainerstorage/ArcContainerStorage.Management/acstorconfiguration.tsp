import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./configurationstate.tsp";

using Azure.ResourceManager;

namespace Microsoft.ArcContainerStorage;

@doc("AcStorConfiguration defines the configuration for a storage system. It is a singleton which must be named 'acstor-configuration'.")
model AcStorConfiguration is ExtensionResource<AcStorConfigurationProperties> {
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
  diskMountPoint?: string;

  @doc("The capacity of the disk, including storage unit (e.g., 60Gi).")
  @pattern("^[0-9][0-9]*([.][0-9]+)?[KMGTP]i?$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  diskCapacity: string;

  @doc("The linux IO interface to use.")
  ioInterface?: IoInterfaces;

  @doc("Configuration for creating a storage pool.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  createStoragePool?: StoragePoolConfig;

  @doc("io engine cpu limit")
  @pattern("^([0-9]+m?|0[.][0-9]+)?$")
  ioEngineCpuLimit?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Read only object to reflect changes that have occurred on the Edge. Similar to Kubernetes status property for custom resources.")
  @visibility(Lifecycle.Read)
  status?: AcStorConfigurationStatus;
}

// Define the storage pool configuration
@doc("Defines the configuration for creating a storage pool.")
model StoragePoolConfig {
  @doc("Whether to create a storage pool.")
  enabled?: boolean;

  @doc("The number of replicas to create.")
  @minValue(1) // Minimum value constraint
  @maxValue(128) // Maximum value constraint
  replicas?: int32;

  @doc("The name of the storage pool.")
  name?: string;

  // We need a liquid transform for this
  @doc("The storage engine to use.")
  engineType?: EngineTypes;

  @doc("The type of disk to use.")
  diskType?: DiskTypes;
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
  state?: ConfigurationState;

  @doc("Additional details about the configuration's status.")
  details?: string;
}

// Define the operations for the AcStorConfiguration resource
@armResourceOperations
interface AcStorConfigurations {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AcStorConfiguration>;
  delete is ArmResourceDeleteWithoutOkAsync<AcStorConfiguration>;
  get is ArmResourceRead<AcStorConfiguration>;
  list is ArmResourceListByParent<AcStorConfiguration>;
  update is ArmResourcePatchAsync<
    AcStorConfiguration,
    AcStorConfigurationProperties
  >;
}
