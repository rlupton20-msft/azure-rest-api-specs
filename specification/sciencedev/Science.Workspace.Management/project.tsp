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

  @doc("Settings for configuring Science Catalog agent availability.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  agentIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/agent";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog tool availability.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  toolIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/tool";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog Model availability.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  modelIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/model";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog Knowledge Base availability.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  knowledgeBaseIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/knowledgeBase";
    }
  ]>[];

  @doc("Settings for configuring Science Data Container availability for DataAsset.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dataContainerIds: DataContainerId[];
}

@armResourceOperations
interface Projects {
  get is ArmResourceRead<Project>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Project>;
  update is ArmResourcePatchSync<Project, ProjectProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Project>;
  listByResourceGroup is ArmResourceListByParent<Project>;
  listBySubscription is ArmListBySubscription<Project>;
}
