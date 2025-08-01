import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

// CodeScanSites Supported API Versions.
import "./CodeScanSitesApiVersions.tsp";

// Add CodeScanSites resource routes here.
import "./codescanroutes.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "The operations endpoint is implemented at a common place required for this resource provider."
@armProviderNamespace
@service(#{ title: "Azure Application Migration Service - CodeScanSites" })
@versioned(CodeScanSitesApiVersions)
@doc("Azure Application Migration CodeScanSites Resource Provider management API.")
namespace Microsoft.ApplicationMigration;