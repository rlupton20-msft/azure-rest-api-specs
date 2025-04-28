import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Catalog tracked resource")
model Catalog is TrackedResource<CatalogProperties> {
  ...ResourceNameParameter<Catalog>;
}

@doc("Catalog properties")
model CatalogProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The URI/URL for the Catalog user interface.")
  @visibility(Lifecycle.Read)
  catalogUiUri?: url;

  @doc("The URI/URL for the Catalog data plane API.")
  @visibility(Lifecycle.Read)
  catalogApiUri?: url;

  ...MoboConfigurationWithMrg;
}

@armResourceOperations
interface Catalogs {
  get is ArmResourceRead<Catalog>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Catalog>;
  update is ArmResourcePatchAsync<Catalog, CatalogProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Catalog>;
  listByResourceGroup is ArmResourceListByParent<Catalog>;
  listBySubscription is ArmListBySubscription<Catalog>;
}
