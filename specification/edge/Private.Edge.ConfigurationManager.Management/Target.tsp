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

namespace Private.Edge;

@doc("Available Solution Template Version for a solution template")
model AvailableSolutionTemplateVersion {
  @doc("Solution template version Id")
  solutionTemplateVersionId: string;

  @doc("Latest configured revision number for a solution template version")
  latestConfigRevision: string;

  @doc("Boolean to indicate whether it is configured")
  isConfigured: boolean;
}

@doc("Applicable Solution Template - contains all versions of a solution template")
model ApplicableSolutionTemplate {
  @doc("Solution template Id")
  solutionTemplateId: string;

  @doc("All Solution template versions for a solution template")
  @extension("x-ms-identifiers", [])
  availableSolutionTemplateVersions?: AvailableSolutionTemplateVersion[];
}

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

  @doc("target spec")
  targetSpecification: string;

  @doc("List of capabilities")
  capabilities: string[];

  @doc("Hierarchy Level")
  hierarchyLevel: string;

  @doc("Custom location of target")
  customLocation: string;

  @doc("Scope of the target resource")
  solutionScope?: string;

  @doc("All applicable solution templates and solution template versions for this target")
  @visibility("read")
  @extension("x-ms-identifiers", [])
  applicableSolutionTemplates?: ApplicableSolutionTemplate[];

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Target Resource")
model Target is TrackedResource<TargetProperties> {
  ...ResourceNameParameter<Target>;
}

@armResourceOperations
interface Targets {
  @doc("Get a Target Resource")
  get is ArmResourceRead<Target>;

  @doc("Create or update a Target Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Target>;

  @doc("update a Target Resource")
  update is ArmResourcePatchSync<Target, TargetProperties>;

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
