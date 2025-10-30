import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./applink.tsp";
import "./applinkmember.tsp";
import "./applinkmemberupgradehistory.tsp";
import "./applinkavailableversion.tsp";

using Versioning;
using Azure.ResourceManager;

/** Private.CloudAppLink Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Private.CloudAppLink management service" })
@versioned(Versions)
namespace Private.CloudAppLink;

/** The available API versions. */
enum Versions {
  /** 2025-04-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_04_01_preview: "2025-04-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}
