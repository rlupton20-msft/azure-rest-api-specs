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

@doc("Reference to a Catalog artifact.")
model Artifact {
  @doc("Catalog artifact ID")
  @visibility("read", "create", "update")
  id: string;

  @doc("Catalog artifact name")
  @visibility("read", "create", "update")
  name: string;
}

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

  @doc("Settings for configuring Science Catalog tool availability.")
  @visibility("read", "create", "update")
  tools: Artifact[];

  @doc("Settings for configuring Science Catalog Model availability.")
  @visibility("read", "create", "update")
  models: Artifact[];

  @doc("Settings for configuring Science Catalog Knowledge Base availability.")
  @visibility("read", "create", "update")
  knowledgeBases: Artifact[];

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
