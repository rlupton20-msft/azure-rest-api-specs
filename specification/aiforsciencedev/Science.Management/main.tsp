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

/** Microsoft.AiForScience Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.AiForScience management service",
})
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

interface Operations extends Azure.ResourceManager.Operations {}
