import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("Validation Test")
model ValidationTest is TrackedResource<ValidationTestProperties> {
  ...ResourceNameParameter<ValidationTest>;
}

@doc("Validation Test properties")
model ValidationTestProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("The flag to enable or disable the test.")
  enabled: boolean = true;

  @doc("Category Ids the test belongs to. Keeping it as an array even though right now it would be 1:1 mapping.")
  categories: string[];

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  overallState: ValidationTestOverallState;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationTestState;

  @doc("The state conditions of the resource.")
  @visibility(Lifecycle.Read)
  stateCondition?: StateCondition;

  @doc("The validation test configuration.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  testConfiguration: ValidationTestConfiguration[];
}

@doc("The Overall states of the validation test.")
union ValidationTestOverallState {
  @doc("The test is in draft state.")
  Draft: "Draft",

  @doc("The test is in published state.")
  Published: "Published",

  @doc("The test is in active state.")
  Active: "Active",

  @doc("The test is in disabled state.")
  Disabled: "Disabled",

  string,
}

@doc("The validation test resource provisioning state.")
union ValidationTestState {
  ResourceProvisioningState,

  @doc("The validation test is getting created.")
  Creating: "Creating",

  @doc("The validation test is ready.")
  Ready: "Ready",

  @doc("The validation test is starting.")
  Starting: "Starting",

  @doc("The validation test is running.")
  Running: "Running",

  @doc("The validation test is getting updated.")
  Updating: "Updating",

  @doc("The validation test is stopping.")
  Stopping: "Stopping",

  @doc("The validation test is stopped.")
  Stopped: "Stopped",

  @doc("The validation test is errored out.")
  Error: "Error",

  @doc("The validation test is getting deleted.")
  Deleting: "Deleting",

  string,
}

@doc("Validation Test Configuration")
model ValidationTestConfiguration {
  @doc("Author (Email Id) of the Test package.")
  author: string;

  @doc("Version of the package.")
  version: string;

  @doc("License under which this package is released. E.g., MIT.")
  license: string;

  @doc("All the input parameters, their types etc. details.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  inputConfiguration: Object[];

  @doc("All the metrics that will be emitted by this test.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  outputMetrics: Object[];

  @doc("""
    Specifies the resources required by this package. e.g, 
    ```
    [
      {
        "resourceType": "Microsoft.Compute/virtualMachines",
        "count": 2
      }
    ]```
    """)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  resources: Object[];

  @doc("""
    Lists the dependencies required by the package. e.g., 
    ```[{"iperf3":"3.9.0"}]```
    """)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(50)
  dependencies: Object[];

  @doc("Specifies the underlying executor for the package.")
  executor: string;

  @doc("The language used to implement the package.")
  language: string;

  @doc("Contains commands to manage the package lifecycle.")
  commands: Object;

  @doc("""
    Command to install the package dependencies and setup. e.g.,
    ```"Install-Module -Name Az -AllowClobber -Force; Invoke-WebRequest -Uri 'https://iperf.fr/download/iperf_3.9.0/iperf3.exe' -OutFile 'C:\\iperf3.exe'"```
    """)
  installationCommand: string;

  @doc("Command to execute the main functionality of the package.")
  executionCommand: string;

  @doc("Command to cleanup the package after execution.")
  cleanupCommand: string;
}

@armResourceOperations
@tag("Validation Test Interfaces")
interface ValidationTests {
  @doc("Get a validation test")
  get is ArmResourceRead<ValidationTest>;

  @doc("Create or update a validation test")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ValidationTest>;

  @doc("Update a validation test")
  @parameterVisibility(Lifecycle.Update)
  update is ArmResourcePatchAsync<ValidationTest, ValidationTestProperties>;

  @doc("Delete a validation test")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationTest>;

  @doc("List validation tests by resource group")
  listByResourceGroup is ArmResourceListByParent<
    ValidationTest,
    Parameters = PaginationQueryParameters
  >;

  @doc("List validation tests by subscription")
  listBySubscription is ArmListBySubscription<
    ValidationTest,
    PaginationQueryParameters
  >;
}
