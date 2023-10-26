import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./index.tsp";
import "./indexer.tsp";
import "./versions.tsp";

using Autorest;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@versioned(Private.Search.Versions)
@armProviderNamespace
@service({
    title: "IndexManagementClient"
})
@doc("CognitiveSearch Resource Provider management API.")
namespace Private.Search;
