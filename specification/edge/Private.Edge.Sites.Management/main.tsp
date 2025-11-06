import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

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
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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

alias SubscriptionParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Custom operation on the scope of subscription"
interface SitesBySubscription {
  list is ArmListBySubscription<Site>;
  get is ArmResourceRead<Site, BaseParameters = SubscriptionParameters>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
  update is ArmCustomPatchSync<
    Site,
    SiteUpdate,
    BaseParameters = SubscriptionParameters
  >;
  delete is ArmResourceDeleteSync<
    Site,
    BaseParameters = SubscriptionParameters
  >;
}
