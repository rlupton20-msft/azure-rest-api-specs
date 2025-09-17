import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./precheckrequest.tsp";

using Http;
using Rest;
using Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Graytown Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Private.Graytown management service" })
@versioned(Versions)
namespace Private.Graytown;

/** The available API versions. */
enum Versions {
  /** 2023-04-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2023-04-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
