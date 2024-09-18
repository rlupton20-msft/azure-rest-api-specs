import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Bakeryrp;

/** Ingredient resource */
model Ingredient is ProxyResource<IngredientProperties> {
  ...ResourceNameParameter<Ingredient>;
}

/** Ingredient properties */
model IngredientProperties {
  /** Age of ingredient */
  age?: int32;

  /** City of ingredient */
  city?: string;

  /** Profile of ingredient */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Ingredients {
  get is ArmResourceRead<Ingredient>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Ingredient>;
  update is ArmResourcePatchSync<Ingredient, IngredientProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Ingredient>;
  listByResourceGroup is ArmResourceListByParent<Ingredient>;
  listBySubscription is ArmListBySubscription<Ingredient>;
}
