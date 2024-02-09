import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

using Azure.ResourceManager.Foundations;
using Azure.Core;

@armProviderNamespace("Private.ContosoWorkbench")
@service({
  title: "ContosoWorkbench Control Plane API",
  version: "2024-02-08-preview",
})
@doc("Provides operations for working with ContosoWorkbench")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.ContosoWorkbench;

@doc("ContosoWorkbench service version.")
enum Versions {
  @doc("Version 024-02-08")
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  `2024-02-08-preview`,
}

@doc("The provisioning state of a resource.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Resource has unknown state.")
  Unknown,

  @doc("Resource is being validated.")
  Validating,

  @doc("Resource provisioning in progress.")
  Processing,

  @doc("Resource is being deleted.")
  Deleting,

  @doc("Resource provisioning action accepted.")
  Accepted,

  @doc("Resource has been deleted.")
  Deleted,
}

@doc("The property for specifying the status of the last operation.")
model ProvisioningStateProperty {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Application set to be installed on workload")
enum Applications {
  @doc("AI & Data Science")
  AiAndDataScience,

  @doc("Signal Processing")
  SignalProcessing,

  @doc("Control Systems")
  ControlSystems,
}

@doc("Toolboxes available for workload")
enum Toolbox {
  @doc("Deep Learning Toolbox")
  DeepLearning,

  @doc("Curve Fitting Toolbox")
  CurveFitting,

  @doc("Statistics Toolbox")
  Statistics,
}

@doc("Parameter sets available for workload")
enum ParameterSet {
  @doc("Block Parameter 1")
  BlockParameter1,
}

@doc("ContosoWorkbench properties.")
model ContosoWorkbenchProperties {
  ...ProvisioningStateProperty;

  @visibility("read", "create")
  @doc("ModsimWorkbench id.")
  modsimWorkbenchId: string;

  @visibility("read", "create")
  @doc("Application set to be installed on workload")
  applications: Applications;

  @visibility("read", "create")
  @doc("Toolbox for workload")
  toolbox: Toolbox;

  @visibility("read", "create")
  @doc("Parameter set for workload")
  parameterSet: ParameterSet;

  @visibility("read", "create")
  @doc("Text of user license to be uploaded from local file")
  userLicenseText: string;
}

@doc("ContosoWorkbench tracked resource.")
model ContosoWorkbench is TrackedResource<ContosoWorkbenchProperties> {
  @doc("The name of the ContosoWorkbench")
  @segment("contosoWorkbenches")
  @key("workbenchName")
  @TypeSpec.Http.path
  @pattern("^(?!-)(?!.*--)[a-zA-Z][A-Za-z0-9-]{0,63}(?<!-)$")
  name: string;
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface ContosoWorkbenches {
  get is ArmResourceRead<ContosoWorkbench>;
  @doc("Creates ContosoWorkbench and associated MSWB workload")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ContosoWorkbench>;
  // update is ArmResourcePatchAsync<ContosoWorkbench, ContosoWorkbenchProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ContosoWorkbench>;

  listByResourceGroup is ArmResourceListByParent<ContosoWorkbench>;
  listBySubscription is ArmListBySubscription<ContosoWorkbench>;
}
