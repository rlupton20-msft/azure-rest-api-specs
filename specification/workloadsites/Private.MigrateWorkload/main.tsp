import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./workLoadSite.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** private.migrateworkload Resource Provider management API. */
@armProviderNamespace
@service({
  title: "MigrateWorkload service",
  version: "2024-02-20-preview",
})
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v3)
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.MigrateWorkload;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Workload Site")
model WorkLoadSite is TrackedResource<WorkLoadSiteProperties> {
  @doc("The name of the workload site")
  @key("siteName")
  @pattern("^[a-zA-Z0-9-]{3,30}$")
  @segment("workLoadSites")
  @visibility("read")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("The extended location.")
  extendedLocation?: ExtendedLocation;
}

@armResourceOperations
@doc("WorkLoad Site Operations")
interface WorkloadSiteControllers {
  get is ArmResourceRead<WorkLoadSite>;
  delete is ArmResourceDeleteWithoutOkAsync<WorkLoadSite>;
  listByResourceGroup is ArmResourceListByParent<WorkLoadSite>;
  listBySubscription is ArmListBySubscription<WorkLoadSite>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkLoadSite>;
  update is ArmResourcePatchAsync<WorkLoadSite, WorkLoadSiteProperties>;
}
