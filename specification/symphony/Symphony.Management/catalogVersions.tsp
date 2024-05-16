import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.Symphony;

@doc("The properties of the CatalogVersion.")
model CatalogVersionProperties {
  @doc("Provisioning state of the service.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The properties of the CatalogVersion.")
  properties: Record<unknown>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "field is loosely defined and dependent on customer scenarios"
  @doc("The metadata of the CatalogVersion.")
  metadata?: Record<string>;

  @doc("The parent catalog version")
  parentName?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property"
  @doc("The catalogType of the CatalogVersion.")
  catalogType: string;

  @doc("The status of the CatalogVersion.")
  @visibility("read")
  status?: CatalogStatusProperties;
}

@doc("The service entity.")
@resource("versions")
@parentResource(Catalog)
model CatalogVersion is TrackedResource<CatalogVersionProperties> {
  @doc("The name of Azure API Center service.")
  @maxLength(90)
  @minLength(1)
  @pattern("^[a-z0-9]+(\\.[a-z0-9]+)*$")
  @path
  @key("versionName")
  @segment("versions")
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface CatalogVersions {
  @doc("Returns details of the service.")
  get is Azure.ResourceManager.ArmResourceRead<CatalogVersion>;
  @doc("Creates new or updates existing API.")
  createOrUpdate is Azure.ResourceManager.ArmResourceCreateOrReplaceSync<CatalogVersion>;
  @doc("Updates existing service.")
  update is ArmCustomPatchSync<CatalogVersion>;
  @doc("Deletes specified service.")
  delete is ArmResourceDeleteSync<CatalogVersion>;

  listByParent is ArmResourceListByParent<CatalogVersion>;
}
