import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** AKS Arc Capability Resource Provider management API. */
@armProviderNamespace
@service({
  title: "AKSArcCapabilityCheckClient",
})
@versioned(Versions)
namespace Microsoft.AksCapability;

/** AKS Arc Capability Resource Provider API versions */
enum Versions {
  /** 2024-11-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-11-01-preview`,
}

/** AKS Arc Node Capability properties */
model AksNodeCapabilityProperties {
  /** Total number of CPU cores in the node */
  totalCpuCore: int32;

  /** Total memory in MB in the node */
  totalMemoryMb: int32;
}

/** The provisioning state of a resource. */
@lroStatus
union ProvisioningState {
  string,

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** Resource has been created. */
  Succeeded: "Succeeded",

  /** Resource creation failed. */
  Failed: "Failed",

  /** Resource creation was canceled. */
  Canceled: "Canceled",

  /** The resource is being deleted */
  Deleting: "Deleting",
}

/** ClusterInfo resource */
model AksCapability is TrackedResource<AksCapabilityProperties> {
  ...ResourceNameParameter<AksCapability>;
}

/** ClusterInfo properties */
model AksCapabilityProperties {
  /** Information of nodes in the cluster */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", ["nodeIp"])
  nodes?: AksNodeInfo[];

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** NodeInfo */
model AksNodeInfo {
  /** Name of the node */
  name?: string;

  /** Node IP */
  nodeIp?: string;

  /** OS type of the node */
  osType?: string;

  /** OS kernel version of the node */
  osKernelVersion?: string;

  /** Container runtime version running on the node */
  containerRuntimeVersion?: string;

  /** Kubernetes version running on the node */
  kubernetesVersion?: string;

  /** Total memory allocable by the node */
  nodeAllocableMemory?: string;

  /** Available memory of the node */
  nodeAvailableMemory?: string;

  /** List of GPUs present on the node */
  @OpenAPI.extension("x-ms-identifiers", [])
  gpus?: GpuInformation[];
}

/** GPU Information */
model GpuInformation {
  /** Type of the GPU */
  type?: string;

  /** Vendor of the GPU */
  vendor?: string;

  /** Total memory of the GPU in MB */
  totalMemory?: string;

  /** Available memory of the GPU in MB */
  availableMemory?: string;

  /** Nvidia-specific GPU information */
  nvidiaInfo?: NvidiaGpuInformation;

  /** AMD-specific GPU information */
  amdInfo?: AmdGpuInformation;

  /** Intel-specific GPU information */
  intelInfo?: IntelGpuInformation;
}

/** Nvidia GPU Information */
model NvidiaGpuInformation {
  /** MIG support status of the GPU */
  migSupport?: boolean;

  /** MPS support status of the GPU */
  mpsSupport?: boolean;

  /** Kernel driver version of the GPU */
  kernelDriverVersion?: string;

  /** GPU Kubernetes device plugin version */
  devicePluginVersion?: string;

  /** Shared GPU support status */
  sharedGpuSupport?: boolean;

  /** CUDA driver version details */
  cudaDriverVersion?: string;

  /** CUDA runtime version details */
  cudaRuntimeVersion?: string;
}

/** AMD GPU Information */
model AmdGpuInformation {
  /** Placeholder for AMD-specific GPU information */
  /** Kernel driver version of the GPU */
  kernelDriverVersion?: string;
}

/** Intel GPU Information */
model IntelGpuInformation {
  /** Placeholder for Intel-specific GPU information */
  /** Kernel driver version of the GPU */
  kernelDriverVersion?: string;
}

/** Request of the precheckNewDeployment action */
model PrecheckRequest {
  /** yaml file of k8s deployment */
  yamlFile?: string;

  /** helm package to deploy */
  helmPackage?: string;

  /** helm values file used for deployment */
  helmValuesFile?: string;
}

/** Response of the precheckNewDeployment action */
model PrecheckResponse {
  /** The list of potential issues, if empty, the deployment can safely proceed */
  potentialIssues: string[];
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface AksCapabilities {
  get is ArmResourceRead<AksCapability>;

  @doc("Creates resource.")
  create is ArmResourceCreateOrUpdateAsync<AksCapability>;

  @doc("Update resource.")
  update is ArmResourcePatchSync<AksCapability, AksCapabilityProperties>;

  @doc("Delete resource.")
  delete is ArmResourceDeleteSync<AksCapability>;

  listByResourceGroup is ArmResourceListByParent<AksCapability>;
  listBySubscription is ArmListBySubscription<AksCapability>;

  /** Simulate a new deployment and return the potential issues */
  precheckNewDeployment is ArmResourceActionSync<
    AksCapability,
    PrecheckRequest,
    PrecheckResponse
  >;
}
