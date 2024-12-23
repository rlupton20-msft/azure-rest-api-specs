import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Azure Throttling (ATS) Resource Provider")
@service({
  title: "Azure Throttling (ATS)",
})
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
namespace Microsoft.Throttling;

@doc("Service versions")
enum Versions {
  @useDependency(
    Azure.Core.Versions.v1_0_Preview_2,
    Azure.ResourceManager.Versions.v1_0_Preview_1
  )
  @doc("Version 2024-01-01-preview")
  v2024_01_01_preview: "2024-01-01-preview",
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {
  checkNameAvailability is checkGlobalNameAvailability;
  checkNameAvailabilityLocal is checkLocalNameAvailability;
}

@doc("Provisioning state")
@lroStatus
union ProvisioningState {
  @doc("Resource being accepted")
  Accepted: "Accepted",

  @doc("Resource being created")
  Creating: "Creating",

  @doc("Resource being updated")
  Updating: "Updating",

  @doc("Resource being deleted")
  Deleting: "Deleting",

  ResourceProvisioningState,
  string,
}

@doc("Proxy account")
model ProxyAccount is ProxyResource<ProxyAccountProperties> {
  @doc("Proxy account name")
  @key("proxyAccountName")
  @segment("proxyAccounts")
  @path
  @visibility("read")
  @minLength(3)
  @maxLength(128)
  @pattern("^[a-zA-Z][a-zA-Z0-9-]+$")
  name: string;
}

@armResourceOperations
interface ProxyAccounts {
  get is ArmResourceRead<ProxyAccount>;
  create is ArmResourceCreateOrReplaceAsync<ProxyAccount>;
  update is ArmResourcePatchAsync<ProxyAccount, ProxyAccountProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<ProxyAccount>;
  listByResourceGroup is ArmResourceListByParent<ProxyAccount>;
  listBySubscription is ArmListBySubscription<ProxyAccount>;
}

@doc("Proxy account properties")
model ProxyAccountProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Proxy account authentication properties")
  authentication?: ProxyAccountAuthenticationProperties;
}

@doc("Proxy account authentication properties")
model ProxyAccountAuthenticationProperties {
  @doc("Certificate-based authentication properties")
  @extension("x-ms-identifiers", ["subjectName"])
  certificates?: CertificateProperties[];
}

@doc("Throttling account")
model Account is TrackedResource<AccountProperties> {
  @doc("Account name")
  @key("accountName")
  @segment("accounts")
  @path
  @visibility("read")
  @minLength(3)
  @maxLength(128)
  @pattern("^[a-zA-Z][a-zA-Z0-9-]+$")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Account kind")
  @visibility("create", "read")
  @pattern("^direct|indirect,[a-z]+$")
  kind: string;
}

@armResourceOperations
interface Accounts {
  get is ArmResourceRead<Account>;
  create is ArmResourceCreateOrReplaceAsync<Account>;
  update is ArmResourcePatchAsync<Account, AccountProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Account>;
  listByResourceGroup is ArmResourceListByParent<Account>;
  listBySubscription is ArmListBySubscription<Account>;
}

@doc("Account properties")
model AccountProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Endpoint address to be used by Throttling client")
  @visibility("read")
  hostName?: string;

  @doc("Account authentication properties")
  authentication?: AccountAuthenticationProperties;
}

@doc("Account authentication properties")
model AccountAuthenticationProperties {
  @doc("Certificate-based authentication properties")
  @extension("x-ms-identifiers", ["subjectName"])
  certificates?: CertificateProperties[];

  @doc("AzureAD-based authentication properties")
  @extension("x-ms-identifiers", ["tenantId", "objectId"])
  azureActiveDirectory?: AzureActiveDirectoryProperties[];
}

@doc("Certificate-based authentication properties")
model CertificateProperties {
  @doc("Certificate subject name")
  @minLength(3)
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9.-]+")
  subjectName: string;
}

@doc("AzureAD-based authentication properties")
model AzureActiveDirectoryProperties {
  @doc("AzureAD Tenant ID")
  tenantId: uuid;

  @doc("AzureAD Object ID")
  objectId: uuid;
}

@doc("Throttling category")
@parentResource(Account)
model Category is TrackedResource<CategoryProperties> {
  @doc("Throttling category name")
  @key("categoryName")
  @segment("categories")
  @path
  @visibility("read")
  @minLength(3)
  @maxLength(128)
  @pattern("^[a-zA-Z0-9-]+$")
  name: string;
}

@armResourceOperations
interface Categories {
  get is ArmResourceRead<Category>;
  create is ArmResourceCreateOrReplaceAsync<Category>;
  update is ArmResourcePatchAsync<Category, CategoryProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Category>;
  listByAccount is ArmResourceListByParent<Category>;
}

@doc("Category properties")
model CategoryProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Threshold value")
  @minValue(1)
  threshold: int32;

  @doc("Depth of the bucket")
  @minValue(-16)
  @maxValue(-1)
  depth: int32;

  @doc("Window duration")
  // TODO: define, see task #27581502
  //@minValue("?")
  //@maxValue("?")
  windowDuration: duration;

  @doc("Minimal decision duration")
  // TODO: define, see task #27581502
  //@minValue("?")
  //@maxValue("?")
  minDecisionDuration: duration;
}
