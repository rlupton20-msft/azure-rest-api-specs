import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

@doc("The name of the GitHub issue.")
scalar IssueName extends string;

/** GitHub Issue resource */
@parentResource(GitHubConnection)
model GitHubIssue is ProxyResource<GitHubIssueProperties> {
  @key("githubIssueId")
  @doc("The GitHub issue identifier")
  @segment("githubIssues")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: IssueName;
}

/** GitHub Issue properties */
model GitHubIssueProperties {
  /** Connection ID */
  connectionId?: string;

  /** Issue status */
  @visibility(Lifecycle.Read)
  status?: GitHubIssueStatus;

  /** Issue ID */
  issueId?: string;

  /** Issue number */
  number?: int32;

  /** Issue title */
  title?: string;

  /** Issue body */
  body?: string;

  /** Indicates if the issue is deleted */
  @visibility(Lifecycle.Read)
  isDeleted?: boolean;

  /** The status of the last operation */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface GitHubIssues {
  /** Get a GitHub Issue */
  get is ArmResourceRead<GitHubIssue>;

  /** Create or update a GitHub Issue */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GitHubIssue>;

  /** Delete a GitHub Issue */
  delete is ArmResourceDeleteWithoutOkAsync<GitHubIssue>;

  /** List GitHub Issues by GitHub Connection */
  listByGitHubConnection is ArmResourceListByParent<GitHubIssue>;
}
