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
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Project tracked resource")
@parentResource(Workspace)
model Project is TrackedResource<ProjectProperties> {
  ...ResourceNameParameter<Project>;
}

@doc("Project properties")
model ProjectProperties {
  //  ...WithTitle;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Settings for configuring Science Catalog agent availability.")
  @visibility("read", "create", "update")
  agentIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/agent";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog tool availability.")
  @visibility("read", "create", "update")
  toolIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/tool";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog Model availability.")
  @visibility("read", "create", "update")
  modelIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/model";
    }
  ]>[];

  @doc("Settings for configuring Science Catalog Knowledge Base availability.")
  @visibility("read", "create", "update")
  knowledgeBaseIds: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AiForScience/knowledgeBase";
    }
  ]>[];

  //    @doc("Settings for configuring Science Catalog Data Asset availability.")
  //    @visibility("read", "create", "update")
  //    dataAssetSettings: Artifact[];
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
