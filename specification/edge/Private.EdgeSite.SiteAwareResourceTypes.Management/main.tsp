import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;
using TypeSpec.Versioning;

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
  @doc("API Version - 2024-02-01-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_02_01_preview: "2024-02-01-preview",
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Displays all the resource types which support Sites.")
@singleton("default")
@tenantResource
@includeInapplicableMetadataInPayload(false)
model SiteAwareResourceType is ProxyResource<SiteAwareResourceTypeProperties> {
  @doc("Name of the resource")
  @path
  @key("siteAwareResourceType")
  @segment("siteAwareResourceTypes")
  @visibility("read")
  @pattern("^default$")
  name: string;
}

#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
@armResourceOperations
@encodedName("application/json", "SiteAwareResourceTypes")
interface SiteAwareResourceTypes {
  @doc("Get operation on SiteAwareResourceType resource")
  get is ArmResourceRead<SiteAwareResourceType>;

  @doc("List operation on SiteAwareResourceType resource")
  list is ArmResourceListByParent<SiteAwareResourceType>;
}
