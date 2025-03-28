import "./namespace-prp.tsp";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Bookshelf.Management/all.tsp";
import "../Discovery.Catalog.Management/all.tsp";
import "../Discovery.Workspace.Management/all.tsp";
import "../Discovery.Supercomputer.Management/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Azure.Discovery Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Azure.Discovery management service" })
@versioned(Azure.Discovery.Versions)
namespace Azure.Discovery;

interface Operations extends Azure.ResourceManager.Operations {}
