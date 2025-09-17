import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./workspace.tsp";
import "./project.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Science tool tracked resource")
@parentResource(Workspace)
model ScienceTool is TrackedResource<ScienceToolProperties> {
  ...ResourceNameParameter<ScienceTool>;
}

@doc("Science Tool properties")
model ScienceToolProperties {
  ...WithTitle;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Tool description used for copilot prompt and execution.")
  @visibility("read", "create", "update")
  description: string;

  @doc("Reference to catalog tool definition.")
  @visibility("read", "create", "update")
  catalogToolReference: Artifact;
}

@armResourceOperations
interface ScienceTools {
  get is ArmResourceRead<ScienceTool>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScienceTool>;
  update is ArmResourcePatchSync<ScienceTool, ScienceToolProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ScienceTool>;
  listByWorkspace is ArmResourceListByParent<ScienceTool>;
}
