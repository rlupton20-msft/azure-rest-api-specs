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
model AzureMonitorDashboardImportDetail
  is Azure.ResourceManager.ProxyResource<AzureMonitorDashboardImportDetailsProperties> {
  ...ResourceNameParameter<
    Resource = AzureMonitorDashboardImportDetail,
    KeyName = "importName",
    SegmentName = "azureMonitorDashboardImportDetails",
    NamePattern = "^[a-zA-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]$"
  >;
}

@armResourceOperations
interface AzureMonitorDashboardImportDetails {
  /**
   * Get the properties of a specific Azure Monitor dashboard import.
   */
  @added(Versions.v2025_09_01_preview)
  get is ArmResourceRead<AzureMonitorDashboardImportDetail>;

  /**
   * Import an Azure Monitor dashboard into Grafana workspace.
   */
  @added(Versions.v2025_09_01_preview)
  @doc("Import an Azure Monitor dashboard into Grafana workspace.")
  @put
  @armResourceCreateOrUpdate(AzureMonitorDashboardImportDetail)
  create(
    ...ResourceInstanceParameters<AzureMonitorDashboardImportDetail>,

    @doc("The import Azure Monitor dashboard resource to create or update.")
    @bodyRoot
    requestBodyParameters: AzureMonitorDashboardImportDetail,
  ): {
    @statusCode _: 200;

    @doc("Resource 'AzureMonitorDashboardImportDetail' update operation succeeded")
    @body
    @added(Versions.v2025_09_01_preview)
    requestBodyParameters: AzureMonitorDashboardImportDetail;
  } | {
    @statusCode _: 201;

    @doc("Resource 'AzureMonitorDashboardImportDetail' create operation succeeded")
    @body
    @added(Versions.v2025_09_01_preview)
    requestBodyParameters: AzureMonitorDashboardImportDetail;
  } | ErrorResponse;

  /**
   * Delete an Azure Monitor dashboard import.
   */
  @added(Versions.v2025_09_01_preview)
  delete is ArmResourceDeleteSync<AzureMonitorDashboardImportDetail>;

  /**
   * List all Azure Monitor dashboard imports under the specified Grafana workspace.
   */
  @added(Versions.v2025_09_01_preview)
  list is ArmResourceListByParent<
    AzureMonitorDashboardImportDetail,
    Response = ArmResponse<AzureMonitorDashboardImportDetailsListResponse>
  >;
}

@@doc(AzureMonitorDashboardImportDetail.name,
  "The name of the Azure Monitor Dashboard Import."
);
@@doc(AzureMonitorDashboardImportDetail.properties,
  "Properties specific to the import Azure Monitor Dashboard resource."
);
