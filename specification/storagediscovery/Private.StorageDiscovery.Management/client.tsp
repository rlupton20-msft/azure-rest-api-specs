import "./main.tsp";
import "./workspace.tsp";
import "./report.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Private.StorageDiscovery;

// SDK configuration- report is not supported in the SDK
@@scope(StorageDiscoveryWorkspaces.report, "none");
@@scope(Report, "none");