import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

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
  catalogUiUri?: string;

  @doc("The URI/URL for the Catalog data plane API.")
  @visibility(Lifecycle.Read)
  catalogApiUri?: string;

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
