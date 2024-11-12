using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

@doc("AszLabHardware current api versions")
enum AszLabHardwareCurrentVersion {
  @doc("2024-11-01-privatepreview api version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-11-01-privatepreview`,
}
