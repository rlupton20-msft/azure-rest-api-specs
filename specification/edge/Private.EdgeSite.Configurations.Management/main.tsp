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
@service({
    title: "Private Edge Sites",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Private.EdgeSite;

@doc("Supported API Versions")
enum Versions {
    @doc("API Version - 2024-06-01-preview")
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    @useDependency(Azure.Core.Versions.v1_0_Preview_1)
    v2024_06_01_preview: "2024-06-01-preview",
}

@armResourceOperations
interface Configurations {
    get is ArmResourceRead<Configuration>;
    createOrUpdate is ArmResourceCreateOrReplaceAsync<Configuration>;
    update is ArmResourcePatchSync<Configuration, ConfigurationProperties>;
    delete is ArmResourceDeleteWithoutOkAsync<Configuration>;
    listByResourceGroup is ArmResourceListByParent<Configuration>;
    listBySubscription is ArmListBySubscription<Configuration>;
}
