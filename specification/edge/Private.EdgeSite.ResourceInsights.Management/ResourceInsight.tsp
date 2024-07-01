import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Private.EdgeSite;
/**
 * An Edge Aggregation resource for resource insights
 */
model ResourceInsight
  is Azure.ResourceManager.ExtensionResource<ResourceInsightProperties> {
  /**
   * Name of resource insight
   */
  @pattern("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$")
  @path
  @key("resourceInsightName")
  @segment("resourceInsights")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ResourceInsights {
  /**
   * Get a ResourceInsight
   */
  get is ArmResourceRead<ResourceInsight>;

  /**
   * List ResourceInsight resources by parent
   */
  list is ArmResourceListByParent<ResourceInsight>;
}

@@doc(ResourceInsight.name, "Name of resource insight");
