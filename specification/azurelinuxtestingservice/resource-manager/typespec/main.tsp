// Necessary libraries to build an Azure Service
import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./test_case.tsp";
import "./job_template.tsp";
import "./job.tsp";
import "./test_result.tsp";

// Include models, operations, and decorators
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using Azure.Core;
using Azure.Core.Foundations;
using OpenAPI;

/*
Requirements for defining an ARM Service:
- Define the service namespace & decorate with
  - serviceTitle
  - serviceVersion
  - armProviderNamespace
*/
@armProviderNamespace
@service({
    title: "Azure Linux Testing Service",
    version: "2023-08-01-preview"

})


@doc("This is the Azure Linux Validation Service")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureLinuxTestingService; 


// Common elements:
@doc("General resource properties.")
model ResourceProperties {
	@doc("Resource provisioning state.")
	@visibility("read")
  @lroStatus
	provisioningState?: ProvisioningState;
}


// Extend the provisioning state
@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState, // Succeeded, Failed, and Canceled
  Queued,
  Provisioning,
  Running,
  Cancelling,
}


interface Operations extends Azure.ResourceManager.Operations {}
