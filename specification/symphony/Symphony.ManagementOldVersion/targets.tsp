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
model TargetProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the TargetVersion.")
  metadata?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the TargetVersion.")
  properties?: Record<string>;

  @doc("The display name of the TargetVersion.")
  displayName?: string;

  @doc("The constraints of the TargetVersion.")
  constraints?: string;

  @doc("The scope of the TargetVersion.")
  scope?: string;

  @doc("A list of topologies")
  @OpenAPI.extension("x-ms-identifiers", [])
  topologies?: TopologyProperties[];

  @doc("A list of components")
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: ComponentProperties[];

  @doc("The reconciliationPolicy of the TargetVersion.")
  reconciliationPolicy?: ReconciliationPolicyProperties;
}

@doc("The service entity.")
model Target is TrackedResource<TargetProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Targets {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<Target>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<Target>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<Target>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<Target>;
  @doc("Returns a collection of services within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Target>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Target>;
}
