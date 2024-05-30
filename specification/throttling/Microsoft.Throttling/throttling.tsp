import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Azure Throttling Service (ATS)")
@service({
  title: "Azure Throttling",
})
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
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
  authentication: AuthenticationProperties;
}

@doc("Account authentication properties")
model AuthenticationProperties {
  @doc("Certificate-based authentication properties")
  @extension("x-ms-identifiers", ["subjectName"])
  @minItems(1)
  certificates?: CertificateProperties[];

  @doc("AzureAD-based authentication properties")
  @extension("x-ms-identifiers", ["objectId"])
  @minItems(1)
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
  @doc("Category name")
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
  listByParent is ArmResourceListByParent<Category>;
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
