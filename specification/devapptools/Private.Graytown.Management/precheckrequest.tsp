import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Graytown;

/** The extended location. */
model ExtendedLocation {
  /** The extended location type. */
  type?: string;

  /** The extended location name. */
  name?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

/** PreCheckRequest resource */
model PreCheckRequest is ExtensionResource<PreCheckRequestProperties> {
  ...ResourceNameParameter<PreCheckRequest>;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

/** PreCheckRequest properties */
model PreCheckRequestProperties {
  /** Pod resource requirements */
  podResourceRequirements?: PodResourceRequirement[];

  /** Validation mode */
  @doc("Determines how the validation webhook handles the request")
  validationMode?: ValidationMode = ValidationMode.ValidateOnly;

  /** The status of the precheck request */
  @visibility(Lifecycle.Read)
  status?: PreCheckRequestStatus;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Pod resource requirement */
model PodResourceRequirement {
  /** Name of the pod */
  name?: string;

  /** CPU requirement */
  cpu?: string;

  /** Memory requirement */
  memory?: string;

  /** Ephemeral storage requirement */
  ephemeralStorage?: string;

  /** GPU count requirement */
  gpuCount?: int32;

  /** GPU memory requirement */
  gpuMemory?: string;

  /** GPU vendor requirement */
  @doc("GPU vendor type")
  gpuVendor?: GPUVendor;

  /** List of GPU architectures that are acceptable (e.g., "turing", "ampere") */
  gpuArchitectures?: string[];

  /** List of GPU products that are acceptable (e.g., "Tesla-T4", "Tesla-V100") */
  gpuProducts?: string[];

  /** Container NVIDIA driver version */
  containerNvidiaDriverVersion?: string;

  /** Minimum Kubernetes version required by this workload */
  @pattern("[0-9]+\\.[0-9]+\\.[0-9]+")
  minimumKubernetesVersion?: string;

  /** Required OS type for the nodes */
  @doc("Operating system type")
  operatingSystem?: OperatingSystem;

  /** Minimum kernel version required by this workload */
  @pattern("[0-9]+\\.[0-9]+\\.[0-9]+([-\\.][0-9a-zA-Z]+)*")
  minimumKernelVersion?: string;

  /** Allowed Kubernetes distributions for this workload */
  @doc("Common values: k3s, aks, eks, gke, rke, rke2, microk8s, kind, minikube, openshift, rancher, vmware, kubeadm")
  kubernetesDistributions?: string[];

  /** Field to enforce node labels, labelKey: labelVal */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This property uses Record<string> which represents a map data structure from Kubernetes"
  nodeSelector?: Record<string>;
}

/** GPU vendor types */
@doc("Supported GPU vendors")
union GPUVendor {
  /** NVIDIA GPU */
  NVIDIA: "NVIDIA",

  /** AMD GPU */
  AMD: "AMD",

  /** INTEL GPU */
  INTEL: "INTEL",

  /** String value for extensibility */
  string,
}

/** Validation mode types */
@doc("Determines how the validation webhook handles the request")
union ValidationMode {
  /** Validate and reject if validation fails */
  ValidateAndReject: "ValidateAndReject",

  /** Validate but save the request regardless of validation results */
  ValidateOnly: "ValidateOnly",

  /** String value for extensibility */
  string,
}

/** Operating system types */
@doc("Supported operating system types")
union OperatingSystem {
  /** Linux operating system */
  Linux: "linux",

  /** Windows operating system */
  Windows: "windows",

  /** String value for extensibility */
  string,
}

/** PreCheck request status */
model PreCheckRequestStatus {
  /** Overall result of the validation */
  overallResult?: string;

  /** Validation details */
  @OpenAPI.extension("x-ms-identifiers", #[])
  details?: ValidationDetail[];
}

/** Node reason details */
model NodeReason {
  /** Node name */
  nodeName?: string;

  /** Reasons list */
  reasons?: string[];
}

/** Validation detail */
model ValidationDetail {
  /** Pod name */
  pod?: string;

  /** Validation result */
  result?: string;

  /** Validation reason */
  reason?: string;

  /** Node name */
  node?: string;

  /** Issue description */
  issue?: string;

  /** Node reasons */
  @OpenAPI.extension("x-ms-identifiers", #["nodeName"])
  nodeReasons?: NodeReason[];
}

/** The resource provisioning state. */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

@armResourceOperations
interface PreCheckRequests {
  get is ArmResourceRead<PreCheckRequest>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PreCheckRequest>;
  update is ArmResourcePatchSync<PreCheckRequest, PreCheckRequestProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<PreCheckRequest>;
  list is ArmResourceListByParent<PreCheckRequest>;
}
