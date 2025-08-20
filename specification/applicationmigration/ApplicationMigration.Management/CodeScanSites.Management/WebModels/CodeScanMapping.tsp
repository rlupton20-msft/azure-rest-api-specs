import "../models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.ApplicationMigration;

@doc("Configuration properties for the code scan mapping.")
model CodeScanMappingConfigurations {
  @doc("The ARM ID of the connection.")
  connectionArmId?: string;

  @doc("The issue ID.")
  issueId?: string;

  @doc("The external application name.")
  externalAppName?: string;

  @doc("The migration target.")
  target?: MigrationTarget;
}

@doc("Report information for the code scan mapping.")
model CodeScanMappingReports {
  @doc("The ARM ID of the report.")
  reportArmId?: string;

  @doc("The report ID.")
  @visibility(Lifecycle.Read)
  reportId?: string;

  @doc("The report name.")
  @visibility(Lifecycle.Read)
  reportName?: string;

  @doc("The report type.")
  @visibility(Lifecycle.Read)
  reportType?: ReportType;

  @doc("The migrate Gartner R rating.")
  @visibility(Lifecycle.Read)
  migrateGartnerR?: string;

  @doc("The cloud maturity score.")
  @visibility(Lifecycle.Read)
  cloudMaturityScore?: string;

  @doc("The green score.")
  @visibility(Lifecycle.Read)
  greenScore?: string;

  @doc("The security score.")
  @visibility(Lifecycle.Read)
  securityScore?: string;

  @doc("The effort in hours.")
  @visibility(Lifecycle.Read)
  effortInHr?: int32;
}

@doc("Details for the code scan mapping.")
model CodeScanMappingDetails {
  @doc("The timestamp when the mapping was last updated.")
  @visibility(Lifecycle.Read)
  updatedTimestamp?: utcDateTime;

  @doc("The timestamp when the mapping was created.")
  @visibility(Lifecycle.Read)
  createdTimestamp?: utcDateTime;

  @doc("The status of the mapping.")
  @visibility(Lifecycle.Read)
  status?: CodeScanMappingStatus;
}

@doc("CodeScanMapping properties.")
model CodeScanMappingProperties {
  @doc("The provisioning state of the CodeScanMapping.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("Configuration properties for the code scan mapping.")
  configurations?: CodeScanMappingConfigurations;

  @doc("Report information for the code scan mapping.")
  reports?: CodeScanMappingReports;

  @doc("Details for the code scan mapping.")
  details?: CodeScanMappingDetails;
}

@doc("CodeScanMapping resource - Extension resource under web app sites.")
model CodeScanMapping
  is Azure.ResourceManager.ExtensionResource<CodeScanMappingProperties> {
  @doc("CodeScanMapping name")
  @key("codeScanMappingName")
  @segment("codeScanMappings")
  @path
  @pattern("^appcatScanReport-[a-zA-Z0-9]+$")
  name: string;
}
