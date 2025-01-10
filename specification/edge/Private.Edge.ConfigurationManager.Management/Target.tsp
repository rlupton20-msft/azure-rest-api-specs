import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./SolutionVersion.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Private.Edge;

@doc("Solution Template Version Parameter")
model SolutionTemplateVersionParameter {
  @doc("Solution Template Version Id")
  solutionTemplateVersionId: string;
}

@doc("Target Properties")
model TargetProperties {
  @doc("Description of target")
  description: string;

  @doc("Display name of target")
  displayName: string;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Suppress no-unknown to handle the datatype object used in dependent service"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Suppress arm-no-record to handle the datatype object used in dependent service"
  @doc("target spec")
  targetSpecification: Record<unknown>;

  @doc("List of capabilities")
  capabilities: string[];

  @doc("Hierarchy Level")
  hierarchyLevel: string;

  @doc("Scope of the target resource")
  solutionScope?: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Target Resource")
model Target is Azure.ResourceManager.TrackedResource<TargetProperties> {
  @doc("Name of the target")
  @maxLength(61)
  @minLength(3)
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$")
  @path
  @key("targetName")
  @segment("targets")
  name: string;

  ...EntityTagProperty;
  ...ExtendedLocationProperty;
}

@armResourceOperations
interface Targets {
  @doc("Get a Target Resource")
  get is ArmResourceRead<Target>;

  @doc("Create or update a Target Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Target>;

  @doc("update a Target Resource")
  update is ArmResourcePatchAsync<Target, TargetProperties>;

  @doc("Delete a Target Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Target>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Target>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Target>;

  @doc("Post request to deploy")
  deploy is ArmResourceActionAsync<Target, SolutionVersion, Instance>;

  @doc("Post request to resolve configuration")
  resolveConfiguration is ArmResourceActionAsync<
    Target,
    SolutionTemplateVersionParameter,
    SolutionVersion
  >;

  @doc("Post request to publish")
  publish is ArmResourceActionAsync<
    Target,
    SolutionTemplateVersionParameter,
    SolutionVersion
  >;
}
