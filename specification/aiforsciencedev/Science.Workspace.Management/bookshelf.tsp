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
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Bookshelf tracked resource")
model Bookshelf is TrackedResource<BookshelfProperties> {
  ...ResourceNameParameter<Bookshelf>;
}

// @doc("Meta-data that should not be in API unless special param is sent")
// model InternalMetaData {
//   @doc("Internal: Azure Sql Server Endpoint")
//   @visibility("read")
//   azureSqlServerEndpoint?: string;

//   @doc("Internal: Azure OpenAi Endpoint")
//   @visibility("read")
//   azureOpenAiEndpoint?: string;
// }

@doc("Bookshelf properties")
model BookshelfProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  /** The managed resource group name */
  @visibility("read")
  managedResourceGroup: string;

  /** The bookshelf dataplane API URI */
  @visibility("read")
  bookshelfApiUri: string;

  // ...InternalMetaData;
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
