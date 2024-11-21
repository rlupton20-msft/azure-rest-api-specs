import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../AiForScience.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Catalog tracked resource")
model Catalog is TrackedResource<CatalogProperties> {
  ...ResourceNameParameter<Catalog>;
}

@doc("Catalog properties")
model CatalogProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The URI/URL for the catalog user interface.")
  @visibility("read")
  catalogUiUri: string;
}

@armResourceOperations
interface Catalogs {
  get is ArmResourceRead<Catalog>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Catalog>;
  update is ArmResourcePatchSync<Catalog, CatalogProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Catalog>;
  listByResourceGroup is ArmResourceListByParent<Catalog>;
  listBySubscription is ArmListBySubscription<Catalog>;
}
