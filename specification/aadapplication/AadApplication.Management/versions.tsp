import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@versioned(Microsoft.AadApplication.Versions)
namespace Microsoft.AadApplication;

@doc("Supported versions.")
enum Versions {
  // The "2025-08-01-preview" version is introduced during namespace separation initiative for above ARM scenarios.
  @doc("API version 2025-08-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2025_08_01_preview: "2025-08-01-preview",
}
