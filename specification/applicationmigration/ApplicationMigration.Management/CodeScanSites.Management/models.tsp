using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("The report framework for code scanning.")
union ReportFramework {
  @doc("Java framework.")
  Java: "Java",

  @doc(".NET framework.")
  DOTNET: "DOTNET",

  string,
}

@doc("The target platform for migration.")
union MigrationTarget {
  @doc("Azure Kubernetes Service.")
  AKS: "AKS",

  @doc("App Service Container.")
  ASC: "ASC",

  @doc("App Service Native.")
  ASN: "ASN",

  string,
}

@doc("The report format.")
union ReportFormat {
  @doc("JSON format.")
  JSON: "JSON",

  string,
}

@doc("The report type.")
union ReportType {
  @doc("AppCAT report type.")
  AppCAT: "AppCAT",

  string,
}

@doc("The status of the report.")
union ReportStatus {
  @doc("The report is available.")
  Available: "Available",

  @doc("Scan has been requested.")
  ScanRequested: "ScanRequested",

  string,
}

@doc("The status of the process operation.")
union ProcessStatus {
  @doc("The operation has been accepted.")
  Accepted: "Accepted",

  string,
}

@doc("The issue category.")
union IssueCategory {
  @doc("Issue category.")
  Issue: "Issue",

  @doc("Warning category.")
  Warning: "Warning",

  @doc("Info category.")
  Info: "Info",

  string,
}

@doc("The code scan mapping status.")
union CodeScanMappingStatus {
  @doc("The mapping operation has succeeded.")
  Succeeded: "Succeeded",

  @doc("The mapping operation is in progress.")
  InProgress: "InProgress",

  @doc("The mapping operation has failed.")
  Failed: "Failed",

  string,
}

@doc("SAS URI response model.")
model SasUriResponse {
  @doc("The SAS URI for uploading reports.")
  sasuri: string;
}

@doc("Process report request model.")
model ProcessReportRequest {
  @doc("Properties for processing the report.")
  properties: ProcessReportProperties;
}

@doc("Properties for processing the report.")
model ProcessReportProperties {
  @doc("The SAS URI of the report to process.")
  sasuri: string;

  @doc("The type of the report.")
  reportType: ReportType;
}

@doc("Process report response model.")
model ProcessReportResponse {
  @doc("The status of the process operation.")
  status: ProcessStatus;

  @doc("The ARM ID of the created job.")
  jobArmId: string;
}

@doc("Reference link model.")
model ReferenceLink {
  @doc("The URL of the reference link.")
  url: string;

  @doc("The label of the reference link.")
  label: string;
}
