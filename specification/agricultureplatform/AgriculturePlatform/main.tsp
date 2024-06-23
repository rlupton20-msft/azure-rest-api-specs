import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Microsoft.AgriculturePlatform")
@service({
  title: "Microsoft.AgriculturePlatform"
})

@versioned(Microsoft.AgriculturePlatform.Versions)
namespace Microsoft.AgriculturePlatform;

@doc("Supported API versions for the Microsoft.AgriculturePlatform resource provider.")
enum Versions {
  @doc("The 2024-06-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}


interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A AgriculturePlatform resource")
model AgriServiceResource is TrackedResource<AgriServiceResourceProperties> {
  @doc("The name of the AgriService resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("agriServiceResourceName")
  @segment("agriService")
  @visibility("read")
  @path
  name: string;

  @doc("System data pertaining to the resource")
  @visibility("read")
  systemData?: AgriServiceResourceSystemData;
  ...ManagedServiceIdentity;
  ...TagsUpdateModel<AgriServiceResource>;
  ...ResourceSku;
}

@doc("System metadata pertaining to the AgriService resource.")
model AgriServiceResourceSystemData {
	...SystemData;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the Agriculture AgriDataManager.")
model AgriServiceResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Config of the AgriService instance.")
  @visibility("read")
  config?: AgriServiceConfig;

  @doc("Data connectors object of AgriService instance.")
  @visibility("read", "create", "update")
  dataConnectors?: Record<DataConnector>;

  @doc("AgriService installed solutions.")
  @visibility("read", "create", "update")
  solutions?: Record<Solution>;
}

@doc("Config of the AgriService instance.")
model AgriServiceConfig {
  @doc("Instance URI of the AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  instanceUri?: string;

  @doc("Cosmos DB endpoint of the AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  cosmosDbEndpoint?: string;

  @doc("Version of AgriService instance.")
  @visibility("read")
  @minLength(2)
  @maxLength(256)
  version?: string;
}

@doc("The properties related to an AgriService data connector.")
model DataConnector {
  @doc("Data connector credentials.")
  @visibility("read", "create", "update")
  credentials?: AuthCredentials;
}

@doc("Model for data connector credentials.")
model AuthCredentials {
  @doc("Type of credential.")
  @visibility("read", "create", "update")
  kind?: AuthCredentialsKind;

  @doc("Client ID associated with the provider, if type of credentials is OAuthClientCredentials.")
  @visibility("read", "create", "update")
  @minLength(1)
  clientId?: string;

  ...KeyVaultProperties;
}

@doc("Enum for different kind of Data connector auth credentials supported.")
enum AuthCredentialsKind {
  @doc("OAuthClientCredentials kind.")
  OAuthClientCredentials,

  @doc("ApiKeyAuthCredentials kind.")
  ApiKeyAuthCredentials,
}

@doc("Properties of the key vault.")
model KeyVaultProperties {
  @doc("URI of the key vault")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(100)
  keyVaultUri?: string;

  @doc("Name of the key vault key.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  keyName?: string;

  @doc("Version of the key vault key.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  keyVersion?: string;
}

@doc("AgriService solution model.")
model Solution {
  @doc("Application name of the solution.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  applicationName?: string;

  @doc("Partner ID.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  partnerId?: string;

  @doc("SAAS subscription ID.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  saasSubscriptionId?: string;

  @doc("SAAS subscription name.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  saasSubscriptionName?: string;

  @doc("Plan ID.")
  @visibility("read", "create", "update")
  @minLength(2)
  @maxLength(256)
  planId?: string;
}

@armResourceOperations(AgriServiceResource)
interface AgriService  {
  get is ArmResourceRead<AgriServiceResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AgriServiceResource>;
  update is ArmResourcePatchAsync<AgriServiceResource, AgriServiceResourceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<AgriServiceResource>;
  listByResourceGroup is ArmResourceListByParent<AgriServiceResource>;
  listBySubscription is ArmListBySubscription<AgriServiceResource>;
}