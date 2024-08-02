import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./CapabilityList.tsp";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Dummy model for testing")
union testunion {
  @doc("test1 description")
  test1: "test1",

  @doc("test2 description")
  test2: "test2",

  @doc("test3 description")
  test3: "test3",

  string
}

@doc("Dummy model for testing")
union testunion2 {
  @doc("test1 description")
  test4: "test1",

  @doc("test2 description")
  test5: "test2",

  @doc("test3 description")
  test6: "test3",

  string
}

@doc("Deployment Target Properties")
model DeploymentTargetProperties {
  @doc("Dummy property for testing")
  testProperty: testunion;

  @doc("Dummy property for testing")
  testProperty2?: testunion2;

  @doc("Display Name of deployment target")
  displayName: string;

  @doc("Custom location of deployment target")
  customLocation: string;

  @doc("List of capabilities")
  @extension("x-ms-identifiers", [])
  capabilities: Capability[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Deployment Target Resource")
model DeploymentTarget is TrackedResource<DeploymentTargetProperties> {
  ...ResourceNameParameter<DeploymentTarget>;
}

@armResourceOperations
interface DeploymentTargets {
  @doc("Get a Deployment Target Resource")
  get is ArmResourceRead<DeploymentTarget>;

  @doc("Create or update a Deployment Target Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentTarget>;

  @doc("update a Deployment Target Resource")
  update is ArmResourcePatchSync<DeploymentTarget, DeploymentTargetProperties>;

  @doc("Delete a Deployment Target Resource")
  delete is ArmResourceDeleteSync<DeploymentTarget>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<DeploymentTarget>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<DeploymentTarget>;
}
