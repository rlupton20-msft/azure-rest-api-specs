import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./version.tsp";
import "./routes.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace("Private.Mission")
@service(#{ title: "Private.Mission" })
@versioned(Microsoft.Mission.Versions)
@doc("Private.Mission Resource Provider management API.")
namespace Microsoft.Mission;

interface Operations extends Azure.ResourceManager.Operations {}
