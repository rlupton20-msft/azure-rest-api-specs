import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Azure BCDR Test Provider API.
 */
@armProviderNamespace
@service({
  title: "Microsoft.BcdrTest Management Service",
})
@versioned(Versions)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v4)
namespace Microsoft.BcdrTest;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-06-01-preview API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_06_01_preview: "2023-06-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The properties of an extension vault.")
model ExtensionVaultProperties {
  /**
   * The additional properties of the extension vault.
   */
  additionalProperties?: string;

  ...DefaultProvisioningStateProperty;
}

@doc("An extension vault resource.")
@parentResource(ArmLocationResource)
model ExtensionVault is ExtensionResource<ExtensionVaultProperties> {
  /**
   * Name of the resource
   */
  @key("extensionVaultName")
  @segment("extensionVault")
  @pattern("^[a-zA-Z0-9_-]+$")
  @path("extensionVaultName")
  name: string;
}

@armResourceOperations(ExtensionVault)
interface ExtensionVaultOperations
  extends ExtensionResourceOperations<
      ExtensionVault,
      ExtensionVaultProperties
    > {}
