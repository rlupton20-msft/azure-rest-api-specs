import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./amfdeployment.tsp";
import "./smfdeployment.tsp";
import "./upfdeployment.tsp";
import "./nrfdeployment.tsp";
import "./nssfdeployment.tsp";
import "./clusterservice.tsp";
import "./observabilityservice.tsp";
import "./sdmdeployment.tsp";
import "./vnfagentdeployment.tsp";
import "./virtualizedmmedeployment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@doc("Mobile Packet Core Management API")
@armProviderNamespace("Microsoft.MobilePacketCore")
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
@service({
  title: "Microsoft.MobilePacketCore Mobile Packet Core Service",
})
@versioned(Versions)
namespace Microsoft.MobilePacketCore;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("API Versions")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("October 15, 2023 Preview API Version")
  v2023_10_15_preview: "2023-10-15-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("March 15, 2024 Preview API Version")
  v2024_03_15_preview: "2024-03-15-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("June 1, 2024 Preview API Version")
  v2024_06_01_preview: "2024-06-01-preview",
}

@@visibility(Azure.Core.Page.nextLink);
