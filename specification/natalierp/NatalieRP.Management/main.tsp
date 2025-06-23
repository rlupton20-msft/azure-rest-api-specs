import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./employee.tsp";
import "./player.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Private.NatalieRP Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Private.NatalieRP management service" })
@versioned(global.Private.NatalieRP.Versions)
namespace Private.NatalieRP;

/** The available API versions. */
enum Versions {
  /** 2024-04-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_04_01_preview: "2024-04-01-preview",
  
  /** 2024-05-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_05_01_preview: "2024-05-01-preview",
}


/** The operations endpoint for the provider. */
interface Operations extends Azure.ResourceManager.Operations {}