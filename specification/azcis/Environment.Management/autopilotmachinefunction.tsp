import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/http";
import "@typespec/rest";

using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;

namespace Microsoft.AzureCis;

@doc("AutopilotMachineFunction properties")
model AutopilotMachineFunctionResourceProperties {
  @doc("Goal state of MachinesFunctions.")
  @Azure.ResourceManager.identifiers(#[])
  machineFunctions?: Array<MachineFunction>; // Camel case for the parameter names.

  @doc("Target Environment Name to allocate MachineFunction.")
  environmentName: string;

  @doc("Target Cluster where Target Environment lives in.")
  clusterName: string;

  @doc("Name of the source environment. Legacy Machines will move out of this environment to the environment that need to be allocated.")
  sourceEnvironment: string;

  @doc("Name of the source mana tree. If extra logical machines needed for allocation, logic machines will borrow from this ManaTree.")
  sourceManaTree: string;

  @doc("Name of the target mana tree. If extra logical machines needed for allocation, logic machines will write into this ManaTree.")
  targetManaTree: string;

  @doc("If a RequestedNodeLabel declared inside of MachineFunction, this particular MachineFunction will filled with this RequestedNodeLabels, but if no such requestedNodeLabel in ManaTree files, it will throw exception.")
  requestedNodeLabels?: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: EnvironmentProvisioningState;
}

@doc("MachineFuncion.")
model MachineFunction {
  @doc("Name of Machine Function allocated machines need to assign to.")
  machineFunctionName: string;

  @doc("Allocation Type options: LegacyMachine - allocate and update machines in machines.csv; NonLegacyMachine (LogicalNameMachine, LogicalMachine, AzureVM, ApContainer etc.) - allocate and update machines in allocation.ini.")
  allocationType: string;

  @doc("If a RequestedNodeLabel declared inside of MachineFunction, this particular MachineFunction will filled with this RequestedNodeLabels, but if no such requestedNodeLabel in ManaTree files, it will throw exception.")
  requestedNodeLabels?: string;

  @doc("Number of machines being requested for this machine function.")
  numberOfMachines: string;

  @doc("Customized and non-required attribute needed to check-in in the allocation.ini file.")
  additionalFields?: Array<string>;
}

@doc("AutopilotMachineFunction Resource")
model AutopilotMachineFunctionResource
  is ProxyResource<AutopilotMachineFunctionResourceProperties> { // This can be TrackedResource based on resourcetype.
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("autopilotMachineFunctions") // Start with lower case. Should be plural.
  @visibility(Lifecycle.Read)
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
