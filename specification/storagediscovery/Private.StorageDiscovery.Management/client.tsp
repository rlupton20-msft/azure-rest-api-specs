import "./main.tsp";
import "./workspace.tsp";
import "./report.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Private.StorageDiscovery;

// suppress report operations
@@scope(StorageDiscoveryWorkspaces.report, "none");
@@scope(Report.get, "none");
@@scope(Report.report, "none");
@@scope(Report.listByResourceGroup, "none");
@@scope(Report.listBySubscription, "none");

// make report operations internal
@@access(StorageDiscoveryWorkspaces.report, Access.internal);
@@access(Report.get, Access.internal);
@@access(Report.report, Access.internal);
@@access(Report.listByResourceGroup, Access.internal);
@@access(Report.listBySubscription, Access.internal);
