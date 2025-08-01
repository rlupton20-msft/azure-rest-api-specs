import "./WebModels/CodeScanSite.tsp";
import "./WebModels/CodeScanReport.tsp";
import "./WebModels/CodeScanIssue.tsp";
import "./WebModels/CodeScanMapping.tsp";
import "./CodeScanSitesApiVersions.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@armResourceOperations
interface CodeScanSitesOperations {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByResourceGroup is ArmResourceListByParent<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listBySubscription is ArmListBySubscription<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanSite>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  update is ArmCustomPatchSync<CodeScanSite, TagsUpdate>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<CodeScanSite>;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "FetchSASUri Action body is empty."
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  fetchSasUri is ArmResourceActionSync<
    CodeScanSite,
    {},
    SasUriResponse
  >;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  processReport is ArmResourceActionSync<
    CodeScanSite,
    ProcessReportRequest,
    ProcessReportResponse
  >;
}

@armResourceOperations
interface CodeScanReportsOperations {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanReport>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<CodeScanReport>;
}

@armResourceOperations
interface CodeScanIssuesOperations {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  listByParent is ArmResourceListByParent<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanIssue>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<CodeScanIssue>;
}

@armResourceOperations
interface CodeScanMappingsOperations {
  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  get is ArmResourceRead<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CodeScanMapping>;

  @added(CodeScanSitesApiVersions.v2025_09_09_preview)
  delete is ArmResourceDeleteSync<CodeScanMapping>;
}