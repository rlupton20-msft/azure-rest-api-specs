import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Playwright.Management;

// Private Endpoint Connection Models

// Ref - https://azure.github.io/typespec-azure/docs/libraries/azure-resource-manager/reference/interfaces/#examples

@added(Versions.v2025_10_01_preview)
@doc("Private endpoint connection resource for securing access to Playwright workspace services.")
@parentResource(PlaywrightWorkspace)
model PrivateEndpointConnection is PrivateEndpointConnectionResource;

// Private Link Resource Model

@added(Versions.v2025_10_01_preview)
@doc("Private link resource representing available endpoints for private connectivity to Playwright workspace services.")
@parentResource(PlaywrightWorkspace)
model PrivateLink is PrivateLinkResource {
  ...PrivateLinkResourceParameter;
}

// Private Endpoint Connection Operations

// Alias for standard private endpoint operations provided by Azure Resource Manager
alias PrivateConnectionOperations = PrivateEndpoints<PrivateEndpointConnection>;

@added(Versions.v2025_10_01_preview)
@armResourceOperations
@doc("Operations for managing private endpoint connections that provide secure, private access to Playwright workspace services.")
interface PrivateEndpointConnections {
  @doc("Creates or replaces a private endpoint connection for the Playwright workspace, enabling secure private access.")
  createOrReplace is PrivateConnectionOperations.CreateOrReplaceAsync<PrivateEndpointConnection>;

  @doc("Deletes a private endpoint connection, removing private access to the Playwright workspace.")
  delete is PrivateConnectionOperations.DeleteAsync<PrivateEndpointConnection>;

  @doc("Gets details of a specific private endpoint connection for the Playwright workspace.")
  get is PrivateConnectionOperations.Read<PrivateEndpointConnection>;

  @doc("Lists all private endpoint connections associated with the Playwright workspace.")
  listByPlaywrightWorkspace is PrivateConnectionOperations.ListByParent<PrivateEndpointConnection>;
}

// Private Link Resource Operations

@added(Versions.v2025_10_01_preview)
@armResourceOperations
@doc("Operations for discovering and managing private link resources that enable secure connectivity to Playwright workspace services.")
interface PrivateLinkResources {
  @doc("Lists available private link resources for the Playwright workspace, showing which services can be accessed privately.")
  listByPlaywrightWorkspace is ArmResourceListByParent<PrivateLink>;
}
