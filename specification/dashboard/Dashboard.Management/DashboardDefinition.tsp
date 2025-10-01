import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ManagedDashboard.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Dashboard;
/**
 * The dashboard definition resource type.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ManagedDashboard)
model DashboardDefinition
  is Azure.ResourceManager.ProxyResource<DashboardDefinitionProperties> {
  ...ResourceNameParameter<
    Resource = DashboardDefinition,
    KeyName = "definitionName",
    SegmentName = "dashboardDefinitions",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface DashboardDefinitions {
  /**
   * Get the properties of a specific dashboard definition.
   */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<DashboardDefinition>;

  /**
   * Create a dashboard definition to update dashboard resource.
   */
  @added(Versions.v2025_09_01_preview)
  create is ArmResourceCreateOrReplaceSync<DashboardDefinition>;

  /**
   * Delete a dashboard definition.
   */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteSync<DashboardDefinition>;

  /**
   * List all dashboard definitions under the specified dashboard.
   */
  @added(Versions.v2025_09_01_preview)
  list is ArmResourceListByParent<
    DashboardDefinition,
    Response = ArmResponse<DashboardDefinitionListResponse>
  >;
}

@@doc(DashboardDefinition.name, "The name of the Dashboard Definition.");
@@doc(DashboardDefinition.properties,
  "Properties specific to the dashboard definition resource."
);
@@doc(DashboardDefinitions.create::parameters.resource, "");
