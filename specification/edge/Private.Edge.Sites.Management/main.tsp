import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
@doc("Azure Edge Sites Resource Provider management API.")
@armProviderNamespace
@service(#{ title: "Private.Edge" })
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.Edge;

@doc("Supported API Versions")
enum Versions {
  @doc("API Version - 2024-06-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_06_01_preview: "2024-06-01-preview",
}

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility(Lifecycle.Read)
  name: string;
}

@armResourceOperations
interface Sites {
  get is ArmResourceRead<Site>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;
  update is ArmCustomPatchSync<Site, SiteUpdate>;
  delete is ArmResourceDeleteSync<Site>;
  list is ArmResourceListByParent<Site>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of subscription"
interface SitesBySubscription {
  list is ArmListBySubscription<Site>;
  get is ArmResourceRead<
    Site,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
  update is ArmCustomPatchSync<
    Site,
    SiteUpdate,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
  delete is ArmResourceDeleteSync<
    Site,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}
