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

@doc("The name of the connection.")
scalar ConnectionName extends string;

/** GitHub Connection resource */
@parentResource(ConnectionHub)
model GitHubConnection is ProxyResource<GitHubConnectionProperties> {
  @key("connectionId")
  @doc("The connection identifier")
  @segment("githubConnections")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,62}[a-zA-Z0-9]$")
  name: ConnectionName;
}

/** GitHub Connection properties */
model GitHubConnectionProperties {
  /** GitHub App ID */
  appId?: string;

  /** Token secret ID pointing to customer Key Vault URI to be accessed by WACA MSI */
  tokenSecretId?: string;

  /** GitHub Installation ID */
  installationId?: string;

  /** Connection name */
  connectionName?: string;

  /** Repository URL */
  url?: string;

  /** List of repositories */
  @visibility(Lifecycle.Read)
  repos?: Repository[];

  /** Connection status */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;

  /** Webhook handler URL */
  @visibility(Lifecycle.Read)
  webhookHandlerUrl?: string;

  /** The status of the last operation */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface GitHubConnections {
  /** Get a GitHub Connection */
  get is ArmResourceRead<GitHubConnection>;

  /** Create or update a GitHub Connection */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<GitHubConnection>;

  /** Delete a GitHub Connection */
  delete is ArmResourceDeleteWithoutOkAsync<GitHubConnection>;

  /** List GitHub Connections by Connection Hub */
  listByConnectionHub is ArmResourceListByParent<GitHubConnection>;
}
