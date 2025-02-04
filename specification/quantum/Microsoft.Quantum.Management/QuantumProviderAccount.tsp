import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Versioning;

namespace Microsoft.Quantum;
/**
 * The resource proxy definition object for Quantum ProviderAccount.
 */
@added(Versions.v2025_02_15_preview)
model QuantumProviderAccount
  is Azure.ResourceManager.TrackedResource<ProviderAccountResourceProperties> {
  ...ResourceNameParameter<
    Resource = QuantumProviderAccount,
    KeyName = "ProviderAccountName",
    SegmentName = "providerAccounts",
    NamePattern = "^[a-zA-Z0-9]+(-*[a-zA-Z0-9])*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface ProviderAccounts {
  /**
   * Returns the ProviderAccount resource associated with the given name.
   */
  @added(Versions.v2025_02_15_preview)
  get is ArmResourceRead<QuantumProviderAccount>;

  /**
   * Creates or updates a ProviderAccount resource.
   */
  @added(Versions.v2025_02_15_preview)
  createOrUpdate is ArmResourceCreateOrReplaceAsync<QuantumProviderAccount>;

  /**
   * Updates an existing ProviderAccount's tags.
   */
  @parameterVisibility
  @added(Versions.v2025_02_15_preview)
  updateTags is ArmCustomPatchSync<
    QuantumProviderAccount,
    PatchModel = TagsObject
  >;

  /**
   * Deletes a ProviderAccount resource.
   */
  @added(Versions.v2025_02_15_preview)
  delete is ArmResourceDeleteWithoutOkAsync<QuantumProviderAccount>;

  /**
   * Gets the list of ProviderAccounts within a resource group.
   */
  @added(Versions.v2025_02_15_preview)
  listByResourceGroup is ArmResourceListByParent<QuantumProviderAccount>;

  /**
   * Gets the list of ProviderAccount within a Subscription.
   */
  @added(Versions.v2025_02_15_preview)
  listBySubscription is ArmListBySubscription<QuantumProviderAccount>;
}

@@doc(QuantumProviderAccount.name,
  "The name of the quantum providerAccount resource."
);
@@doc(QuantumProviderAccount.properties,
  "Gets or sets the properties. Define quantum provider account's specific properties."
);
@@doc(ProviderAccounts.createOrUpdate::parameters.resource,
  "ProviderAccount details."
);
@@doc(ProviderAccounts.updateTags::parameters.properties,
  "Parameters supplied to update tags."
);
