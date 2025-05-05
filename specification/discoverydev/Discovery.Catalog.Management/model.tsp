import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Discovery.Shared/shared.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Discovery")
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Models tracked resource")
model Model is TrackedResource<ModelProperties> {
  ...ResourceNameParameter<Model>;
}

@doc("Model properties")
model ModelProperties {
  @doc("Reference to model definition.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  modelDefinitionId: string;

  @doc("Model definition YAML as a string.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  contentDefinitions: string;

  @doc("The ARM resource ID of the workspace.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  workspaceId: Microsoft.Discovery.Shared.WorkspaceId;

  @doc("The provisioning status of the Model.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Models {
  get is ArmResourceRead<Model>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Model>;
  update is ArmResourcePatchAsync<Model, ModelProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Model>;
  listByResourceGroup is ArmResourceListByParent<Model>;
  listBySubscription is ArmListBySubscription<Model>;
}
