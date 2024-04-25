import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("AutopilotMachineFunction properties")
model AutopilotMachineFunctionResourceProperties {
  @doc("Target environment/Cluster name.")
  naming?: Naming; // Camel case for the parameter names.

  @doc("Goal state of MachinesFunctions.")
  @extension("x-ms-identifiers", [])
  machineFunctions?: Array<MachineFunction>;

  @doc("EnvironmentName.")
  environmentName: string;

  @doc("ClusterName.")
  clusterName: string;

  @doc("SourceEnvironment.")
  sourceEnvironment: string;

  @doc("SourceManaTree.")
  sourceManaTree: string;

  @doc("TargetManaTree.")
  targetManaTree: string;

  @doc("RequestedNodeLabels.")
  requestedNodeLabels?: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: EnvironmentProvisioningState;
}

@doc("Target environment/Cluster name.")
model Naming {
  @doc("Parameter name.")
  prefix?: string;

  @doc("Parameter value.")
  cluster?: string;
}

@doc("MachineFuncion.")
model MachineFunction {
  @doc("Machine function name.")
  machineFunctionName: string;

  @doc("AllocationType.")
  allocationType: string;

  @doc("RequestedNodeLabels.")
  requestedNodeLabels?: string;

  @doc("NumberOfMachines.")
  numberOfMachines: string;

  @doc("Goal state of AdditionalFields.")
  additionalFields?: Array<string>;
}

@doc("AutopilotMachineFunction Resource")
model AutopilotMachineFunctionResource
  is ProxyResource<AutopilotMachineFunctionResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("autopilotMachineFunctions") // Start with lower case. Should be plural.
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface AutopilotMachineFunction {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AutopilotMachineFunctionResource>;
  get is ArmResourceRead<AutopilotMachineFunctionResource>;
  listByResourceGroup is ArmResourceListByParent<AutopilotMachineFunctionResource>;
  listBySubscription is ArmListBySubscription<AutopilotMachineFunctionResource>;
}
