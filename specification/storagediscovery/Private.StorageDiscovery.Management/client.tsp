import "./main.tsp";
import "./workspace.tsp";
import "./report.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Private.StorageDiscovery;

// SDK configuration- report is not exposed in the SDKs
@@scope(StorageDiscoveryWorkspaces.report, "none");
@@scope(Report.get, "none");
@@scope(Report.report, "none");
@@scope(Report.listByResourceGroup, "none");
@@scope(Report.listBySubscription, "none");
