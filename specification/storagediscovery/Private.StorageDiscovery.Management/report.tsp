import "./main.tsp";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.CommonTypes;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Private.StorageDiscovery;

@added(ApiVersion.v2025_06_01_preview)
@parentResource(StorageDiscoveryWorkspace)
@doc("A report resource")
model ReportResource is Azure.ResourceManager.ProxyResource<ReportProperties> {
  ...ResourceNameParameter<
    Resource = ReportResource,
    KeyName = "discoveryResourceName",
    SegmentName = "reports"
  >;
}

@added(ApiVersion.v2025_06_01_preview)
@doc("This is an empty model as the Report resource is used only as a proxy for the Report API.")
model ReportProperties {}

@added(ApiVersion.v2025_06_01_preview)
@armResourceOperations
interface Report {
  get is ArmResourceRead<ReportResource>;
  @autoRoute
  @post
  report is ArmResourceActionAsync<
    ReportResource,
    GetReportRequest,
    GetReportResponse
  >;
}
