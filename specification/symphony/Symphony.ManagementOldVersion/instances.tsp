import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.Symphony;

@doc("The properties of the service.")
model InstanceProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the InstanceVersion.")
  metadata?: Record<string>;

  @doc("The display name of the InstanceVersion.")
  displayName?: string;

  @doc("The scope of the InstanceVersion.")
  scope?: string;

  @doc("The solution version.")
  solution: string;

  @doc("The target of the InstanceVersion.")
  target?: TargetSelectorProperties;

  @doc("The reconciliationPolicy of the InstanceVersion.")
  reconciliationPolicy?: ReconciliationPolicyProperties;
}

@doc("The service entity.")
model Instance is TrackedResource<InstanceProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("instanceName")
  @segment("instances")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Instances {
  @doc("Returns details of the service.")
  get is ArmResourceRead<Instance>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Instance>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<Instance>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<Instance>;
  @doc("Returns a collection of services within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Instance>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Instance>;
}
