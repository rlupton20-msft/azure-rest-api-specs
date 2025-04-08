import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Workspace tracked resource")
model Workspace is TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<Workspace>;
}

@doc("Workspace properties")
model WorkspaceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked Storages.")
  @extension("x-ms-identifiers", #["id"])
  storageIds?: Array<StorageId>;

  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @doc("List of linked SuperComputers.")
  @extension("x-ms-identifiers", #["id"])
  supercomputerIds?: Array<SuperComputerId>;

  @doc("workspace API endpoint Uri.")
  @visibility(Lifecycle.Read)
  workspaceApiUri?: string;

  @doc("workspace User Interface Uri.")
  @visibility(Lifecycle.Read)
  workspaceUiUri?: string;

  ...MoboConfigurationWithMrg;
}

@armResourceOperations
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;
  update is ArmResourcePatchAsync<Workspace, WorkspaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;
  listByResourceGroup is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}
