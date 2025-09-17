import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Validate;

@doc("Validation Test Category")
model ValidationTestCategory
  is TrackedResource<ValidationTestCategoryProperties> {
  ...ResourceNameParameter<ValidationTestCategory>;
}

@doc("Validation Test Category properties")
model ValidationTestCategoryProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("The parent test category.")
  parentCategory?: string;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The state conditions of the resource.")
  @visibility(Lifecycle.Read)
  stateCondition?: StateCondition;

  @doc("The validation tests belong to this category.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(500)
  @visibility(Lifecycle.Read)
  tests?: ValidationTest[];

  @doc("The sub categories of the validation test category.")
  @maxItems(100)
  @visibility(Lifecycle.Read)
  subCategories?: string[];
}

@armResourceOperations
@tag("Validation Test Category Interfaces")
interface ValidationTestCategories {
  @doc("Get a validation test category")
  get is ArmResourceRead<ValidationTestCategory>;

  @doc("Create or update a validation test category")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ValidationTestCategory>;

  @doc("Update a validation test category")
  @parameterVisibility(Lifecycle.Update)
  update is ArmResourcePatchAsync<
    ValidationTestCategory,
    ValidationTestCategoryProperties
  >;

  @doc("Delete a validation test category")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationTestCategory>;

  @doc("List validation test categories by resource group")
  listByResourceGroup is ArmResourceListByParent<
    ValidationTestCategory,
    Parameters = PaginationQueryParameters
  >;

  @doc("List validation test categories by subscription")
  listBySubscription is ArmListBySubscription<
    ValidationTestCategory,
    PaginationQueryParameters
  >;
}
