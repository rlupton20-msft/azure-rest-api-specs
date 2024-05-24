import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Private.EdgeSite;

@doc("Site as ARM Resource")
model Site is ProxyResource<SiteProperties> {
  @doc("Name of Site resource")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
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
