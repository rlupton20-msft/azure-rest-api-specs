import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

@doc("Azure Throttling Solutions (ATS)")
@service({
  title: "Azure Throttling",
})
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.Throttling;

enum Versions {
  @useDependency(
    Azure.Core.Versions.v1_0_Preview_2,
    Azure.ResourceManager.Versions.v1_0_Preview_1
  )
  v2022_06_01_preview: "2022-06-01-preview",
}

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Autorest;
using Azure.ResourceManager;
using OpenAPI;

interface Operations extends Azure.ResourceManager.Operations {
  checkNameAvailability is checkGlobalNameAvailability;
  checkNameAvailabilityLocal is checkLocalNameAvailability;
}

@doc("Provisioning state")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("Resource being accepted")
  Accepted,
  @doc("Resource being created")
  Creating,
  @doc("Resource being updated")
  Updating,
  @doc("Resource being deleted")
  Deleting,
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
  create is ArmResourceCreateOrReplaceSync<Account>;
  update is ArmResourcePatchSync<Account, AccountProperties>;
  delete is ArmResourceDeleteSync<Account>;
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
  @extension("x-ms-identifiers", [ "subjectName" ])
  @minItems(1)
  certificates?: CertificateProperties[];

  @doc("AzureAD-based authentication properties")
  @extension("x-ms-identifiers", [ "objectId" ])
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
  @format("uuid")
  tenantId: string;

  @doc("AzureAD Object ID")
  @format("uuid")
  objectId: string;
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
  create is ArmResourceCreateOrReplaceSync<Category>;
  update is ArmResourcePatchSync<Category, CategoryProperties>;
  delete is ArmResourceDeleteSync<Category>;
  listByParent is ArmResourceListByParent<Category>;
}

@doc("Category properties")
model CategoryProperties {
  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Window duration")
  windowDuration: duration;

  @doc("Minimal decision duration")
  minDecisionDuration: duration;

  @doc("Threshold value")
  @minValue(1)
  threshold: int32;

  @doc("Depth of the bucket")
  @minValue(0)
  @maxValue(16)
  depth: int32;
}
