import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

@doc("Supported versions.")
enum Versions {
  // The "2023-08-22-preview" version is preserved to simplify Dogfood testing and not re-register the resource types.
  // Resource specifications in this version match specifications of the latest 2024-06-24-preview version in RPSaaSMaster branch.
  @doc("Dogfood Dev Test API version, 2023-08-22-preview (matches 2024-06-24-preview of RPSaaSMaster).")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  dogfood_dev_test: "2023-08-22-preview",
}
