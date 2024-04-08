import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.AzureValidation;

/** Validator resource */
model Validator is TrackedResource<ValidatorProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("validatorId")
  @path
  @segment("validators")
  @visibility("read")
  @doc("The name of the resource validator.")
  name: string;
}

/** Validator properties */
model ValidatorProperties {
  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/** The resource provisioning state. */
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  /** The resource is being provisioned. */
  Provisioning,

  /** The resource is being updated. */
  Updating,

  /** The resource is being deleted. */
  Deleting,

  /** The resource provisioning request has been accepted. */
  Accepted,
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface Validators {
  get is ArmResourceRead<Validator>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Validator>;
  update is ArmResourcePatchSync<Validator, ValidatorProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Validator>;
  listByResourceGroup is ArmResourceListByParent<Validator>;
  listBySubscription is ArmListBySubscription<Validator>;
}

@doc("An ValidationResult resource.")
model ValidationResult is TrackedResource<ValidationResultProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("validationResultName")
  @segment("validationResults")
  @visibility("read")
  @path
  @doc("The name of the validation result.")
  name: string;
}

@doc("The operation type that can be performed on a resource.")
enum Operation {
  /** The resource is being created. */
  Create,

  /** The resource is being updated. */
  Update,

  /** The resource is being deleted. */
  Delete,
}

@doc("The validation outcome.")
enum Outcome {
  /** The validation succeeded. */
  Succeeded,

  /** The validation failed. */
  Failed,

  /** The validation is pending. */
  Pending,
}

@doc("The properties of ValidationResult")
model ValidationResultProperties {
  @doc("The validator id.")
  validatorId: string;

  @doc("The change control Id")
  changeControlId: string;

  @doc("The token Id")
  tokenId: string;

  @doc("The resource identifier.")
  resourceId: string;

  @doc("The action type")
  operation: Operation;

  @doc("The allowed claim.")
  allowed: boolean;

  @doc("The outcome of the validation.")
  outcome: Outcome;

  @doc("The message.")
  message: string;

  @doc("The error details.")
  error?: {
    code?: string;
    message?: string;
  };

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface ValidationResults {
  get is ArmResourceRead<ValidationResult>;
  create is ArmResourceCreateOrReplaceAsync<ValidationResult>;
  update is ArmResourcePatchSync<ValidationResult, ValidationResultProperties>;
  delete is ArmResourceDeleteSync<ValidationResult>;
  listByResourceGroup is ArmResourceListByParent<ValidationResult>;
  listBySubscription is ArmListBySubscription<ValidationResult>;
}