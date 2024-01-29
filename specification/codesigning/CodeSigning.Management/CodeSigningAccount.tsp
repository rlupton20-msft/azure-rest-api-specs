import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CodeSigning;
@doc("Code signing account resource")
model CodeSigningAccount is TrackedResource<CodeSigningAccountProperties> {
  @doc("Code Signing account name")
  @pattern("^(?=.{3,24}$)[^0-9][A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("accountName")
  @segment("codeSigningAccounts")
  name: string;
}

@armResourceOperations
interface CodeSigningAccounts {
  @doc("Get a Code Signing Account")
  get is ArmResourceRead<CodeSigningAccount>;

  @doc("Create a Code Signing Account")
  create is ArmResourceCreateOrReplaceAsync<
    CodeSigningAccount,
    BaseParameters<CodeSigningAccount>
  >;

  @doc("Update a code signing account")
  update is ArmCustomPatchAsync<
    CodeSigningAccount,
    CodeSigningAccountPatch,
    BaseParameters<CodeSigningAccount>
  >;

  @doc("Delete Code Signing Account")
  delete is ArmResourceDeleteWithoutOkAsync<CodeSigningAccount>;

  @doc("List Code Signing Accounts within a resource group")
  listByResourceGroup is ArmResourceListByParent<CodeSigningAccount>;

  @doc("Lists Code Signing Accounts within a subscription")
  listBySubscription is ArmListBySubscription<CodeSigningAccount>;

  @doc("Checks that the code signing account name is valid and is not already in use.")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailability,
    CheckNameAvailabilityResult
  >;
}

@@doc(CodeSigningAccounts.create::parameters.resource,
  "Parameters to create the code signing account"
);
@@doc(CodeSigningAccounts.update::parameters.properties,
  "Parameters supplied to update code signing account"
);