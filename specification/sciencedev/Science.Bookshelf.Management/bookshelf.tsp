import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Bookshelf tracked resource")
model Bookshelf is TrackedResource<BookshelfProperties> {
  ...ResourceNameParameter<Bookshelf>;
}

@doc("Bookshelf properties")
model BookshelfProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  ...MoboConfigurationWithMrg;

  /** The bookshelf data plane API URI */
  @visibility(Lifecycle.Read)
  bookshelfApiUri?: string;

  @doc("bookshelf User Interface Uri.")
  @visibility(Lifecycle.Read)
  bookshelfUiUri?: string;
}

@armResourceOperations
interface Bookshelves {
  get is ArmResourceRead<Bookshelf>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Bookshelf>;
  update is ArmResourcePatchAsync<Bookshelf, BookshelfProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Bookshelf>;
  listByResourceGroup is ArmResourceListByParent<Bookshelf>;
  listBySubscription is ArmListBySubscription<Bookshelf>;
}
