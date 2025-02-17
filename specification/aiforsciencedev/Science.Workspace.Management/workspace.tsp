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

@doc("Linked Storage.")
model LinkedStorage {
  @doc("Fully qualified resource ID for the Storage account. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Storage/storageAccounts/{accountName}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/storage"; // TODO: Change to Science shared storage?
    }
  ]>;
}

@doc("Linked Bookshelf.")
model LinkedBookShelf {
  @doc("Fully qualified resource ID for the Bookshelf resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/bookshelf";
    }
  ]>;
}

@doc("Linked SuperComputer.")
model LinkedSuperComputer {
  @doc("Fully qualified resource ID for the SuperComputer resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/supercomputer";
    }
  ]>;
}

//@doc("Linked Catalog.")
//model LinkedCatalog {
//  @doc("Fully qualified resource ID for the Catalog resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
//  @visibility("read", "create", "update")
//  id: Azure.Core.armResourceIdentifier<[
//    {
//      type: "Microsoft.Science/catalog";
//    }
//  ]>;
//}

@doc("Workspace tracked resource")
model Workspace is TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<Workspace>;
}

@doc("Workspace properties")
model WorkspaceProperties {
  //  ...WithTitle;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  //  @visibility("read", "create", "update")
  //  @doc("List of linked Catalogs.")
  //  @extension("x-ms-identifiers", ["id"])
  //  catalogs?: Array<LinkedCatalog>;

  @visibility("read", "create", "update")
  @doc("List of linked Storages.")
  @extension("x-ms-identifiers", ["id"])
  storages?: Array<LinkedStorage>;

  //  @visibility("read", "create", "update")
  //  @doc("List of linked Bookshelves.")
  //  @extension("x-ms-identifiers", ["id"])
  //  bookshelves?: Array<LinkedBookShelf>;

  @visibility("read", "create", "update")
  @doc("List of linked SuperComputers.")
  @extension("x-ms-identifiers", ["id"])
  supercomputers?: Array<LinkedSuperComputer>;
}

@armResourceOperations
interface Workspaces {
  get is ArmResourceRead<Workspace>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Workspace>;
  update is ArmResourcePatchSync<Workspace, WorkspaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Workspace>;
  listByResourceGroup is ArmResourceListByParent<Workspace>;
  listBySubscription is ArmListBySubscription<Workspace>;
}
