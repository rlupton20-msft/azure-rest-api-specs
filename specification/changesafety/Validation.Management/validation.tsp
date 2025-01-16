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

model Validation is ProxyResource<ValidationPropertiesExtended> {
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("validationName")
  @path
  @segment("validations")
  @visibility("read")
  @doc("The name of the validation.")
  name: string;
}

@armResourceOperations
interface Validations {
  @doc("Get the validation.")
  get is ArmResourceRead<Validation>;
  getAtSubscriptionLevel is ArmResourceRead<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  getAtTenantLevel is ArmResourceRead<
    Validation,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Creates a validation.")
  create is ArmResourceCreateOrReplaceAsync<Validation>;
  createOrUpdateAtSubscriptionLevel is ArmResourceCreateOrReplaceSync<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  createOrUpdateAtTenantLevel is ArmResourceCreateOrReplaceSync<
    Validation,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Validation can be re-run by doing a PUT operation with the same parameters. The output of the validation will be updated based on the new validation run.")
  update is ArmResourcePatchSync<Validation, ValidationPropertiesExtended>;
  updateAtSubscriptionLevel is ArmResourcePatchSync<
    Validation,
    ValidationPropertiesExtended,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  updateAtTenantLevel is ArmResourcePatchSync<
    Validation,
    ValidationPropertiesExtended,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("Deletes the validation.")
  delete is ArmResourceDeleteSync<Validation>;
  deleteAtSubscriptionLevel is ArmResourceDeleteWithoutOkAsync<
    Validation,
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
    }
  >;
  deleteAtTenantLevel is ArmResourceDeleteWithoutOkAsync<
    Validation,
    {
      ...ApiVersionParameter;
    }
  >;

  @doc("List the validations.")
  listByResourceGroup is ArmResourceListByParent<Validation>;

  @doc("List the validations.")
  listBySubscription is ArmListBySubscription<Validation>;

  // TODO: List by tenant
}
