import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.BrlossSpatio")
@service({
  title: "Microsoft.BrlossSpatio",
  version: "2023-06-27-preview",
})
@doc("Spatio Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.BrlossSpatio;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A Spatio catalog resource")
model GeoCatalog is TrackedResource<GeoCatalogProperties> {
  @doc("The name of the catalog")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("catalogName")
  @path
  @segment("geoCatalogs")
  name: string;
}

@doc("Details of the BrlossSpatio GeoCatalog.")
model GeoCatalogProperties {
  @doc("Tier of the catalog. This cannot be changed after the catalog is created.")
  tier?: CatalogTier;

  @visibility("read")
  @doc("The URI of the catalog management UI.")
  catalogUri?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface GeoCatalogs extends TrackedResourceOperations<GeoCatalog, GeoCatalogProperties> {}

@doc("The Spatio GeoCatalog tier")
enum CatalogTier {
  @doc("The standard tier that utilizes shared resources across catalog instances")
  Standard,
  @doc("The higher performance premium tier that uses dedicated resources per catalog instance")
  Premium,
}

@doc("The status of the current operation.")
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}
