using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@doc("Versions for API")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @doc("2023-09-01-preview")
  v20230901_preview: "2023-09-01-preview",

  @doc("2024-06-01-preview")
  v20240601_preview: "2024-06-01-preview",

  @doc("2024-07-01-preview")
  v20240701_preview: "2024-07-01-preview",

  @doc("2024-08-01-preview")
  v20240801_preview: "2024-08-01-preview",

  @doc("2024-10-01-preview")
  v20241001_preview: "2024-10-01-preview",

  @doc("2024-12-01-preview")
  v20241201_preview: "2024-12-01-preview",

  @doc("2025-01-01-preview")
  v20250101_preview: "2025-01-01-preview",

  @doc("2025-03-01-preview")
  v20250301_preview: "2025-03-01-preview",
}
