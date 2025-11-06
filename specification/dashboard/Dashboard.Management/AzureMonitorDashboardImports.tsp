import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./ManagedGrafana.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Dashboard;
/**
 * The import Azure Monitor dashboard resource type.
 */
@added(Versions.v2025_09_01_preview)
@parentResource(ManagedGrafana)
model AzureMonitorDashboardImport
  is Azure.ResourceManager.ProxyResource<AzureMonitorDashboardImportsProperties> {
  ...ResourceNameParameter<
    Resource = AzureMonitorDashboardImport,
    KeyName = "importName",
    SegmentName = "azureMonitorDashboardImports",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface AzureMonitorDashboardImports {
  /**
   * Get the properties of a specific Azure Monitor dashboard import.
   */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<AzureMonitorDashboardImport>;

  /**
   * Import an Azure Monitor dashboard into Grafana workspace.
   */
  @added(Versions.v2025_09_01_preview)
  @doc("Import an Azure Monitor dashboard into Grafana workspace.")
  @put
  @armResourceCreateOrUpdate(AzureMonitorDashboardImport)
  create(
    ...ResourceInstanceParameters<AzureMonitorDashboardImport>,

    @doc("The import Azure Monitor dashboard resource to create or update.")
    @bodyRoot
    requestBodyParameters: AzureMonitorDashboardImport,
  ): {
    @statusCode _: 200;

    @doc("Resource 'AzureMonitorDashboardImport' update operation succeeded")
    @body
    @added(Versions.v2025_09_01_preview)
    requestBodyParameters: AzureMonitorDashboardImport;
  } | {
    @statusCode _: 201;

    @doc("Resource 'AzureMonitorDashboardImport' create operation succeeded")
    @body
    @added(Versions.v2025_09_01_preview)
    requestBodyParameters: AzureMonitorDashboardImport;
  } | ErrorResponse;

  /**
   * Delete an Azure Monitor dashboard import.
   */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteSync<AzureMonitorDashboardImport>;

  /**
   * List all Azure Monitor dashboard imports under the specified Grafana workspace.
   */
  @added(Versions.v2025_09_01_preview)
  list is ArmResourceListByParent<
    AzureMonitorDashboardImport,
    Response = ArmResponse<AzureMonitorDashboardImportsListResponse>
  >;
}

@@doc(AzureMonitorDashboardImport.name,
  "The name of the Azure Monitor Dashboard Import."
);
@@doc(AzureMonitorDashboardImport.properties,
  "Properties specific to the import Azure Monitor Dashboard resource."
);
