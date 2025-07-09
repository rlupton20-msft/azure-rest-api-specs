import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientNamespace(Private.DurableTask,
  "com.azure.resourcemanager.durabletask",
  "java"
);
@@clientName(Private.DurableTask, "DurableTaskMgmt", "python");
@@clientName(Private.DurableTask, "DurableTaskManagementClient", "java");
