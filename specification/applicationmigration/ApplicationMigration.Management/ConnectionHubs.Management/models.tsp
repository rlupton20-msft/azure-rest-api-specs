import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

/** The resource provisioning state */
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  /** The resource is being provisioned */
  Provisioning: "Provisioning",

  /** The resource is updating */
  Updating: "Updating",

  /** The resource is being deleted */
  Deleting: "Deleting",

  /** The resource create request has been accepted */
  Accepted: "Accepted",

  string,
}

/** Connection status */
union ConnectionStatus {
  string,

  /** Connection is active */
  Active: "Active",

  /** Connection is inactive */
  Inactive: "Inactive",

  /** Connection is failed */
  Failed: "Failed",

  /** Connection is pending */
  Pending: "Pending",
}

/** GitHub issue status */
union GitHubIssueStatus {
  string,

  /** Issue is open */
  Open: "Open",

  /** Issue is closed */
  Closed: "Closed",

  /** Issue is in progress */
  InProgress: "InProgress",
}

/** Tool type for GitHub issues */
union ToolType {
  string,

  /** AppCAT tool type */
  AppCAT: "AppCAT",
}

/** Repository information */
model Repository {
  /** Repository URL */
  url?: string;

  /** Repository ID */
  id?: int32;
}
