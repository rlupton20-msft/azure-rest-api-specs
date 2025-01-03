import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Solution Version Properties")
model SolutionVersionProperties {
  @doc("Latest revision number of resolved config for this solution version")
  @visibility("read")
  latestConfigRevision: int32;

  @doc("Name of applicable target's display name")
  targetDisplayName: string;

  @doc("Resolved configuration values")
  configuration: string;

  @doc("App components spec")
  specification: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Solution Version Resource")
@parentResource(Solution)
model SolutionVersion is ProxyResource<SolutionVersionProperties> {
  ...ResourceNameParameter<
    SolutionVersion,
    // Name will be set to solutionTemplateVersion-latestConfigRevision
    NamePattern = "^[a-zA-Z0-9-]{3,30}$"
  >;
}

@armResourceOperations
interface SolutionVersions {
  @doc("Get a Solution Version Resource")
  get is ArmResourceRead<SolutionVersion>;

  @doc("Create or update a Solution Version Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SolutionVersion>;

  @doc("update an SolutionVersion Resource")
  update is ArmResourcePatchSync<SolutionVersion, SolutionVersionProperties>;

  @doc("Delete a Solution Version Resource")
  delete is ArmResourceDeleteSync<SolutionVersion>;

  @doc("List Solution Version Resources")
  listByTarget is ArmResourceListByParent<SolutionVersion>;
}
