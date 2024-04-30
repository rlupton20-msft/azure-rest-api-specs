import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./disk.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Private.AzsDeviceCom Resource Provider management API. */
@armProviderNamespace("Private.AzsDeviceCom")
@service({
  title: "Private.AzsDeviceCom management service",
})
@versioned(Versions)
namespace Private.AzsDeviceCom;

/** The available API versions. */
enum Versions {
  /** 2024-02-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2024-02-01-preview",
}
