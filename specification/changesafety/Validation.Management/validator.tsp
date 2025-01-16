import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ChangeSafety;

model Validator is ProxyResource<ValidatorProperties> {
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("validatorName")
  @path
  @segment("validators")
  @visibility("read")
  @doc("The name of the resource validator.")
  name: string;
}

@parentResource(Validator)
model ValidatorVersion is ProxyResource<ValidatorVersionProperties> {
  // https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string
  @pattern("^(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$")
  @key("validatorVersionName")
  @path
  @segment("versions")
  @visibility("read")
  @doc("The semantic version of the validator")
  name: string;
}

@doc("Azure resource Id of a Validator.")
scalar ValidatorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/validators",
    }
  ]>;

@doc("Azure resource Id of a Validator.")
scalar ValidatorVersionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/validators/versions",
    }
  ]>;

@armResourceOperations
interface Validators {
  @doc("Get the validator.")
  get is ArmResourceRead<Validator>;
  getValidatorAtSubscriptionLevel is ArmResourceRead<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  getValidatorAtTenantLevel is ArmResourceRead<
    Validator,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Create the validator.")
  create is ArmResourceCreateOrReplaceAsync<Validator>;
  createOrUpdateValidatorAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  createOrUpdateValidatorAtTenantLevel is ArmResourceCreateOrReplaceSync<
    Validator,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Update the validator.")
  update is ArmResourcePatchSync<Validator, ValidatorProperties>;
  updateValidatorAtSubscriptionLevel is ArmResourcePatchSync<
    Validator,
    ValidatorProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  updateValidatorAtTenantLevel is ArmResourcePatchSync<
    Validator,
    ValidatorProperties,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Deletes the validator.")
  delete is ArmResourceDeleteSync<Validator>;
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    Validator,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  deleteAtTenantLevel is ArmResourceDeleteWithoutOkAsync<
    Validator,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("List the validators.")
  listByResourceGroup is ArmResourceListByParent<Validator>;

  @doc("List the validators.")
  listBySubscription is ArmListBySubscription<Validator>;

  // TODO: List by tenant

  @doc("Get the validator version.")
  getVersion is ArmResourceRead<ValidatorVersion>;
  getValidatorVersionAtSubscriptionLevel is ArmResourceRead<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  getValidatorVersionAtTenantLevel is ArmResourceRead<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Create the validator version.")
  createVersion is ArmResourceCreateOrReplaceAsync<ValidatorVersion>;
  createOrUpdateValidatorVersionAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  createOrUpdateValidatorVersionAtTenantLevel is ArmResourceCreateOrReplaceSync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Update the validator version.")
  updateVersion is ArmResourcePatchSync<
    ValidatorVersion,
    ValidatorVersionProperties
  >;
  updateValidatorVersionAtSubscriptionLevel is ArmResourcePatchSync<
    ValidatorVersion,
    ValidatorVersionProperties,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  updateValidatorVersionAtTenantLevel is ArmResourcePatchSync<
    ValidatorVersion,
    ValidatorVersionProperties,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Deletes the validator version.")
  deleteVersion is ArmResourceDeleteSync<ValidatorVersion>;
  deleteValidatorVersionAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  deleteValidatorVersionAtTenantLevel is ArmResourceDeleteWithoutOkAsync<
    ValidatorVersion,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("List the validator versions.")
  listVersionByResourceGroup is ArmResourceListByParent<ValidatorVersion>;

  @doc("List the validator versions.")
  listVersionBySubscription is ArmListBySubscription<ValidatorVersion>;

  // TODO: List by tenant
}
