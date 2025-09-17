import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./workspace.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Project tracked resource")
@parentResource(Workspace)
model Project is TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<Project>;
}

@doc("Project properties")
model ProjectProperties {
  //  ...WithTitle;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("SAllowed Agents (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agentIds: AgentId[];

  @doc("Allowed Tools (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  toolIds: ToolId[];

  @doc("Allowed Models (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  modelIds: ModelId[];

  @doc("Allowed KnowledgeBases (Data plane resource IDs).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  knowledgeBaseIds: string[];

  @doc("Allowed DataContainers (Control plane resource references).")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dataContainerIds: DataContainerId[];
}

@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  update is ArmResourcePatchAsync<Project, ProjectProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  listByResourceGroup is ArmResourceListByParent<Project>;
  listBySubscription is ArmListBySubscription<Project>;
}
