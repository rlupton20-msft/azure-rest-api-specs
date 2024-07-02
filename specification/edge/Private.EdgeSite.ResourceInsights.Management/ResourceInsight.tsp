import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is published as part of same RP in edge folder."
namespace Private.EdgeSite;
/**
 * A Microsoft.Edge connectivity status resource
 */
model ResourceInsight is ExtensionResource<ResourceInsightProperties> {
  /**
   * Name of ResourceInsights
   */
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("ResourceInsightsName")
  @segment("ResourceInsights")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ResourceInsights {
  /**
   * Get a ResourceInsights
   */
  get is ArmResourceRead<ResourceInsight>;

  /**
   * Create a ResourceInsights
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ResourceInsight,
    Azure.ResourceManager.Foundations.BaseParameters<ResourceInsight>,
    ArmAsyncOperationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  
  /**
   * Delete a ResourceInsights
   */
  delete is ArmResourceDeleteSync<ResourceInsight>;

  /**
   * List ResourceInsights resources by parent
   */
  list is ArmResourceListByParent<ResourceInsight>;
}
