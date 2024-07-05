import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

import "./hciCommon.tsp";
// import "./edgeDevices.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

@doc("A EdgeDevice")
@armProviderNamespace("Private.AzureStackHCI")
namespace Private.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model EdgeDevice is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = EdgeDevice,
    KeyName = "edgeDeviceName",
    SegmentName = "edgeDevices",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;
}

// FIXME: Gpu has no properties property
/**
 * GPU resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
@doc("Gpus resource")
@parentResource(EdgeDevice)
@discriminator("kind")
model Gpu is Azure.ResourceManager.ExtensionResource<{}> {
  ...ResourceNameParameter<
    Resource = Gpu,
    KeyName = "default",
    SegmentName = "gpus",
    NamePattern = "^[a-zA-Z0-9-]{3,24}$"
  >;

  /**
   * Edge Solution type to support polymorphic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @visibility("read", "create")
  kind: DeviceType;
}

@armResourceOperations
interface Gpus {
  /**
   * Get a Gpu
   */
  get is ArmResourceRead<Gpu>;

  /**
   * Create a Gpu
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Gpu>;

  /**
   * Delete a Gpu
   */
  delete is ArmResourceDeleteWithoutOkAsync<Gpu>;

  /**
   * List Gpu resources by EdgeDevice
   */
  listByEdgeDevice is ArmResourceListByParent<Gpu>;
}

@@doc(Gpu.name, "Name of Gpu");

///////////////////models///////////

/**
 * Edge device type based on host OS installed.
 */
union DeviceType {
  string,

  /**
   * Arc-enabled edge device with HCI OS.
   */
  HCI: "HCI",

  /**
   * Arc-enabled edge device with WindowsServer OS.
   */
  WindowsServer: "WindowsServer",

  /**
   * Arc-enabled edge device with WindowsIoT OS.
   */
  WindowsIoT: "WindowsIoT",

  /**
   * Arc-enabled edge device with AzureLinux OS.
   */
  AzureLinux: "AzureLinux",

  /**
   * Arc-enabled edge device with UbuntuLinux OS.
   */
  UbuntuLinux: "UbuntuLinux",
}

/**
 * GPU Vendor Type supported.
 */
union GpuVendorType {
  string,

  /**
   * Nvidia GPU.
   */
  Nvidia: "Nvidia",

  /**
   * AMD GPU.
   */
  AMD: "AMD",

  /**
   * Intel GPU.
   */
  Intel: "Intel",
}

/**
 * GPU modes supported.
 */
union GpuMode {
  string,

  /**
   * GPU-P mode.
   */
  GPUP: "GPUP",

  /**
   * DDA mode.
   */
  DDA: "DDA",
}

/**
 * Represents the properties of a GPU.
 */
model GpuProperties {
  /**
   * Set partition size (default: 0 for DDA) For e.g. 2, 4, etc.
   */
  partitionSizeGB?: int32;

  /**
   * The name of the node.
   */
  nodeName?: string;

  /**
   * GPU reported properties.
   */
  @visibility("read")
  reportedProperties?: GpuReportedProperties;
}

/**
 * Represents the reported properties of a log collection job.
 */
model GpuReportedProperties {
  /**
   * The number of GPUs.
   * Is that even required, as we have the count in the list of GPU details?
   * if GPU is not assignable, then should it be considered here?
   */
  @visibility("read")
  gpuCount?: int32;

  /**
   * List of GPU details for this edge device.
   */
  @visibility("read")
  @extension("x-ms-identifiers", ["gpuId"])
  gpuDetails?: GpuDetails[];
}

model GpuDetails {
  /**
   * The ID of the GPU.
   */
  @visibility("read")
  gpuId?: string;

  /**
   * The name of the GPU.
   */
  @visibility("read")
  gpuName?: string;

  /**
   * The vendor of the GPU.
   */
  @visibility("read")
  gpuManufacturer?: string;

  /**
   * The model of the GPU.
   */
  @visibility("read")
  gpuModel?: string;

  /**
   * Specified by admin whether this GPU can be used as DDA, GPU-P, GPU-P with LM. Can only be updated when the GPU is not attached to any VM.
   */
  @visibility("read")
  gpuMode?: GpuMode;

  /**
   * This is the count of total partitions.
   */
  @visibility("read")
  totalPartitions?: int32;

  /**
   * The number of available partitions.
   */
  @visibility("read")
  availablePartitions?: int32;

  /**
   * This is the count of assigned partitions.
   */
  @visibility("read")
  assignedPartitions?: int32;

  /**
   * This is the driver version for the guest on which GPU is assigned
   */
  @visibility("read")
  guestDriverVersion?: string;

  /**
   * This tells if the guest driver is ok or outdated.
   */
  @visibility("read")
  guestDriverStatus?: string;

  /**
   * This is the host driver for the host on which GPU is assigned, only for DDA
   */
  @visibility("read")
  hostDriverVersion?: string;

  /**
   * This is the driver status for the host on which GPU is assigned
   */
  @visibility("read")
  hostDriverStatus?: string;

  /**
   * It is the available processing power to encode video.
   */
  @visibility("read")
  availableEncoder?: string;

  /**
   * It is the available processing power to decode video.
   */
  @visibility("read")
  availableDecoder?: string;

  /**
   * It is a high-speed memory which drivers allow the GPU to borrow from system memory.
   */
  @visibility("read")
  availableVram?: string;

  /**
   * IA set of valid partition counts that's predefined to configure.
   */
  @visibility("read")
  validPartitionCount?: string[];

  @visibility("read")
  @extension("x-ms-identifiers", ["workloadName"])
  workloads?: WorkloadDetails[];
}

/////Fill below model based on understanding
model WorkloadDetails {
  /**
   * This gives information about workload name (VM/AKS)  specifically the VM Name
   */
  @visibility("read")
  workloadName?: string;

  /**
   * This gives information about workload status , running or down
   */
  @visibility("read")
  workloadStatus?: string;

  /**
   * This tells if workload is VM, AKS etc
   */
  @visibility("read")
  workloadType?: string;

  /**
   * This is the unique partition ID for a workload using GPU-P.
   */
  @visibility("read")
  partitionId?: string;

  /**
   * This is the unique instance path for a workload using GPU-P.
   */
  @visibility("read")
  slotLocation?: string;

  /**
   * This tells if confidential mode is available or unavailable for the VM.
   */
  @visibility("read")
  confidentialComputing?: string;
}

model PartitionDetails {
  /**
   * This is the unique partition ID for a GPU-P.
   */
  @visibility("read")
  partitionId?: string;
}
