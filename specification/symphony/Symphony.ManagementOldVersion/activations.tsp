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

@doc("Defining the Activation.")
model ActivationProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The inputs of the Activation.")
  inputs?: Record<unknown>;

  @doc("The stage of the Activation.")
  stage?: string;

  @doc("The campaign version of the Activation.")
  campaign: string;

  @doc("The status of the Activation.")
  @visibility("read")
  status?: ActivationStatusProperties;
}

@doc("The service entity.")
model Activation is TrackedResource<ActivationProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("activationName")
  @segment("activations")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Activations {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<Activation>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<Activation>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<Activation>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<Activation>;
  @doc("Returns a collection of services within the resource group.")
  listByResourceGroup is Azure.ResourceManager.ArmResourceListByParent<Activation>;
  @doc("Lists services within an Azure subscription.")
  listBySubscription is ArmListBySubscription<Activation>;
}
