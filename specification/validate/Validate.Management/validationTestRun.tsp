import "./common.tsp";
import "./validationExecutionPlan.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("Validation Test Run represents execution instance(s) of a Validation Test instance under execution plan.")
@parentResource(ExecutionPlanRun)
model ValidationTestRun is ProxyResource<ValidationTestRunProperties> {
  ...ResourceNameParameter<ValidationTestRun>;
}

@doc("Validation Test Run properties.")
model ValidationTestRunProperties {
  @doc("The overall status of the test run.")
  @visibility(Lifecycle.Read)
  status: ValidationTestRunStatus;

  @doc("The state of the test run.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("The start timestamp of the test run.")
  @visibility(Lifecycle.Read)
  startTimestamp: utcDateTime;

  @doc("The reported timestamp of the test run.")
  @visibility(Lifecycle.Read)
  reportedTimestamp: utcDateTime;

  @doc("The end timestamp of the test run.")
  @visibility(Lifecycle.Read)
  endTimestamp: utcDateTime;

  @doc("Validation test run response code.")
  @visibility(Lifecycle.Read)
  code: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Validation test run inputs.")
  inputs: Record<string>;

  @doc("Detailed pass information when the test passes.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(100)
  passDetails?: ValidationTestPassDetails[];

  @doc("Detailed failure information when the test fails.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(100)
  failureDetails?: ValidationTestFailureDetails[];

  @doc("The metrics of the test run.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(100)
  metrics?: ValidationTestRunMetrics[];
}

@doc("The overall status of the test run.")
union ValidationTestRunStatus {
  @doc("The test run is not running.")
  NotRunning: "NotRunning",

  @doc("The test run is scheduled.")
  Scheduled: "Scheduled",

  @doc("The test run is ready.")
  Ready: "Ready",

  @doc("The test run is running.")
  Running: "Running",

  @doc("The test run is completed.")
  Completed: "Completed",

  @doc("The test run is stopped.")
  Stopped: "Stopped",

  @doc("The test run is errored out.")
  Error: "Error",

  string,
}

@doc("Detailed information about test pass.")
model ValidationTestPassDetails {
  @doc("Result code categorizing the type of pass.")
  @visibility(Lifecycle.Read)
  resultCode: string;

  @doc("test name which passed.")
  @visibility(Lifecycle.Read)
  testName: string;

  @doc("Detailed information about the passed test.")
  @visibility(Lifecycle.Read)
  resultDetails?: string;
}

@doc("Detailed information about test failure.")
model ValidationTestFailureDetails {
  @doc("Error code categorizing the type of failure.")
  @visibility(Lifecycle.Read)
  errorCode: string;

  @doc("Human-readable error message describing the failure.")
  @visibility(Lifecycle.Read)
  errorMessage: string;

  @doc("Detailed information about the failure.")
  @visibility(Lifecycle.Read)
  details?: string;

  @doc("Additional diagnostic information.")
  @visibility(Lifecycle.Read)
  diagnosticInfo?: string;

  @doc("Suggested remediation steps for the customer.")
  @visibility(Lifecycle.Read)
  recommendedActions?: string[];
}

@doc("Metrics of the test run collected.")
model ValidationTestRunMetrics {
  @doc("The name of the metric.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The value of the metric.")
  @visibility(Lifecycle.Read)
  value: float64;

  @doc("The unit of the metric.")
  @visibility(Lifecycle.Read)
  unit: string;

  @doc("The category of the metric collected.")
  @visibility(Lifecycle.Read)
  category?: string;

  @doc("The description about the metric collected.")
  description?: string;

  @doc("Uniquely identifies the record.")
  @visibility(Lifecycle.Read)
  operationId: string;

  @doc("Refers operationId of the parent to support result nesting scheme.")
  @visibility(Lifecycle.Read)
  operationParentId?: string;
}

@doc("The validation test run metrics collection.")
model ValidationTestRunMetricsSeriesCollection {
  @doc("""
    The timespan for which the data was retrieved.
    Its value consists of two datetimes concatenated, separated by '/'.
    This may be adjusted in the future and returned from what was originally requested.
    """)
  @visibility(Lifecycle.Read)
  timespan: string;

  @doc("The metrics of the validation test.")
  @visibility(Lifecycle.Read)
  @maxItems(100)
  @OpenAPI.extension("x-ms-identifiers", #[])
  value: ValidationTestRunMetricsSeries[];
}

@doc("The validation test run metrics series details.")
model ValidationTestRunMetricsSeries {
  @doc("The id of the metric.")
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Refers id of the parent to support result nesting scheme.")
  @visibility(Lifecycle.Read)
  parentId?: string;

  @doc("The resource type of the metric resource.")
  @visibility(Lifecycle.Read)
  type: string;

  @doc("The name of the metric.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The unit of the metric.")
  @visibility(Lifecycle.Read)
  unit: string;

  @doc("The category of the metric collected.")
  @visibility(Lifecycle.Read)
  category?: string;

  @doc("The description of the metric collected.")
  description?: string;

  @doc("The time series returned when a data query is performed.")
  @visibility(Lifecycle.Read)
  @maxItems(100)
  @OpenAPI.extension("x-ms-identifiers", #[])
  timeseries: TimeSeriesMetrics[];
}

@doc("Time series metrics.")
model TimeSeriesMetrics {
  @doc("The timestamp of the metric.")
  @visibility(Lifecycle.Read)
  timeStamp: utcDateTime;

  @doc("The value of the metric.")
  @visibility(Lifecycle.Read)
  value: float64;
}

@armResourceOperations
@tag("Validation Test Run Interfaces")
interface ValidationTestRuns {
  @doc("Get a Validation test run details")
  get is ArmResourceRead<ValidationTestRun>;

  @doc("List Validation test runs for a test under execution plan run instance")
  listByExecutionPlanRun is ArmResourceListByParent<
    ValidationTestRun,
    Parameters = PaginationQueryParameters
  >;

  @doc("Start a Validation test run")
  @actionSeparator(":")
  start is ArmResourceActionNoResponseContentAsync<ValidationTestRun, void>;

  @doc("Stop a Validation test run")
  @actionSeparator(":")
  stop is ArmResourceActionNoResponseContentAsync<ValidationTestRun, void>;

  @doc("Cancel a Validation test run")
  @actionSeparator(":")
  cancel is ArmResourceActionNoResponseContentAsync<ValidationTestRun, void>;

  @doc("Get the metrics of a validation test run")
  @autoRoute
  metrics(
    ...ResourceInstanceParameters<ValidationTestRun>,

    @path
    @doc("The metrics namespace (this parameter will not show up in operations).")
    metricsDetails: "metrics",
  ): ArmResponse<ValidationTestRunMetricsSeriesCollection> | ErrorResponse;
}
