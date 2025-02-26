import "./namespace-prp.tsp";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Science.Catalog.Management/all.tsp";
import "../Science.Supercomputer.Management/all.tsp";
import "../Science.Workspace.Management/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Science Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.Science management service",
})
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

interface Operations extends Azure.ResourceManager.Operations {}
