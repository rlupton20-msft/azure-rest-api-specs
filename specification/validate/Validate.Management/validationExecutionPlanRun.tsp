import "./common.tsp";
import "./validationExecutionPlan.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("The properties of the execution plan run.")
@parentResource(ValidationExecutionPlan)
model ExecutionPlanRun is ProxyResource<ExecutionPlanRunProperties> {
  ...ResourceNameParameter<ExecutionPlanRun>;
}

@doc("The properties of the execution plan run.")
model ExecutionPlanRunProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("The status of the execution plan run.")
  @visibility(Lifecycle.Read)
  status: ExecutionPlanRunStatus;

  @doc("The start time of the execution plan run.")
  @visibility(Lifecycle.Read)
  startTimestamp: utcDateTime;

  @doc("The end time of the execution plan run.")
  @visibility(Lifecycle.Read)
  endTimestamp?: utcDateTime;

  @doc("The reported timestamp of the execution plan run.")
  @visibility(Lifecycle.Read)
  reportedTimestamp: utcDateTime;

  @doc("All the trigger information for this execution.")
  trigger: ExecutionPlanRunTrigger;

  @doc("The test runs under this execution plan run.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(200)
  testRuns: ValidationTestRun[];

  @doc("The provisioning state of the execution plan run.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("The status of the execution plan run.")
@lroStatus
union ExecutionPlanRunStatus {
  @doc("The execution plan run is succeeded.")
  Succeeded: "Succeeded",

  @doc("The execution plan run is running.")
  Running: "Running",

  @doc("The execution plan run is canceled.")
  Canceled: "Canceled",

  @doc("The execution plan run is failed.")
  Failed: "Failed",

  @doc("The execution plan run is waiting.")
  Waiting: "Waiting",

  @doc("The execution plan run is skipped.")
  Skipped: "Skipped",

  @doc("The execution plan run is paused.")
  Paused: "Paused",

  @doc("The execution plan run is suspended.")
  Suspended: "Suspended",

  @doc("The execution plan run is timed out.")
  TimedOut: "TimedOut",

  @doc("The execution plan run is aborted.")
  Aborted: "Aborted",

  @doc("The execution plan run is ignored.")
  Ignored: "Ignored",

  @doc("The execution plan run is unknown.")
  Unknown: "Unknown",

  string,
}

@doc("The trigger information for the execution plan run.")
model ExecutionPlanRunTrigger {
  @doc("The status of the execution plan run trigger.")
  @visibility(Lifecycle.Read)
  status: ExecutionPlanRunStatus;

  @doc("The start time of the execution plan run trigger.")
  @visibility(Lifecycle.Read)
  startTimestamp: utcDateTime;

  @doc("The end time of the execution plan run trigger.")
  @visibility(Lifecycle.Read)
  endTimestamp?: utcDateTime;

  @doc("Name of the trigger.")
  name: string;

  @doc("Trigger response code.")
  @visibility(Lifecycle.Read)
  code: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Trigger inputs.")
  inputs: Record<string>;
}

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

  @doc("The metrics of the test run.")
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  @maxItems(500)
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
  @maxItems(500)
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
  @maxItems(500)
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
@tag("Validation Execution Plan Run Interfaces")
interface ValidationExecutionPlanRuns {
  @doc("Get a Validation test execution plan run details")
  get is ArmResourceRead<ExecutionPlanRun>;

  @doc("List Validation test execution plan runs for an execution plan")
  listByExecutionPlan is ArmResourceListByParent<
    ExecutionPlanRun,
    Parameters = PaginationQueryParameters
  >;

  @doc("Start a Validation test execution plan run")
  @actionSeparator(":")
  start is ArmResourceActionNoResponseContentAsync<ExecutionPlanRun, void>;

  @doc("Stop a Validation test execution plan run")
  @actionSeparator(":")
  stop is ArmResourceActionNoResponseContentAsync<ExecutionPlanRun, void>;

  @doc("Cancel a Validation test execution plan run")
  @actionSeparator(":")
  cancel is ArmResourceActionNoResponseContentAsync<ExecutionPlanRun, void>;
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
