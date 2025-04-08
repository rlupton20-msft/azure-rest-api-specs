import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./employee.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Farmer Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.Farmer management service" })
@versioned(Microsoft.Farmer.Versions)
namespace Microsoft.Farmer;

/** The available API versions. */
enum Versions {
  /** 2025-03-20-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_03_20_preview: "2025-03-20-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
