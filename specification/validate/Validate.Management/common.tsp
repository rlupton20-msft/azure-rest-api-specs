using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Validate;

alias PaginationQueryParameters = ListQueryParametersTrait<{
  ...OrderByQueryParameter;
  ...TopQueryParameter;
  ...FilterQueryParameter;
  ...SkipQueryParameter;
  ...MaxPageSizeQueryParameter;
}>;

@doc("""
  Condition is a abstraction to convey details of what lead the entity into the current state.
  For example - When a new test is in failed state, the condition could be used to convey 'Execution Agent unreachable'.
  """)
model StateCondition {
  @doc("The code for the current state condition of the test execution.")
  code: string;

  @doc("The human readable details for the this condition of the test execution.")
  details: string[];

  @doc("The timestamp of when the state condition was last updated.")
  lastModifiedAt: utcDateTime;
}

@doc("The schedule with which any execution would happen.")
model Schedule is Azure.ResourceManager.ExtensionResource<ScheduleProperties> {
  ...ResourceNameParameter<Schedule>;
}

@doc("The properties of the schedule.")
model ScheduleProperties {
  @doc("The start time of the schedule. DateLiteral using ISO8601, per 1API guidelines.")
  startTime: utcDateTime;

  @doc("The end time of the schedule. DateLiteral using ISO8601, per 1API guidelines.")
  expiryTime?: utcDateTime;

  @doc("Number of units of time to delay before the first execution.")
  initialDelayMilliSeconds?: int64 = -1;

  @doc("The rate of the schedule.")
  rate?: ScheduleRate = ScheduleRate.FixedInterval;

  @doc("The frequency of the schedule.")
  frequency: ScheduleFrequency;

  @doc("The timezone of the schedule.")
  timeZone: string = "UTC";

  @doc("The advanced schedule of the schedule.")
  advancedSchedule?: AdvancedSchedule;

  @doc("The description of the schedule.")
  description?: string;

  @doc("The provisioning state of the schedule.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Schedule rates.")
union ScheduleRate {
  @doc("The schedule will execute with a fixed period between the end of the last invocation and the start of the next.")
  FixedDelay: "FixedDelay",

  @doc("The schedule will execute at a fixed period between invocations.")
  FixedInterval: "FixedInterval",

  string,
}

@doc("Frequency values for the schedule.")
union ScheduleFrequency {
  @doc("The schedule will execute only once.")
  OneTime: "OneTime",

  @doc("The schedule will execute every day.")
  Day: "Day",

  @doc("The schedule will execute every hour.")
  Hour: "Hour",

  @doc("The schedule will execute every week.")
  Week: "Week",

  @doc("The schedule will execute every month.")
  Month: "Month",

  @doc("The schedule will execute every minute.")
  Minute: "Minute",

  string,
}

@doc("Advanced schedule options.")
model AdvancedSchedule {
  @doc("Days of the week that the job should execute on.")
  @maxItems(7)
  weekDays?: WeekDay[];

  @doc("Days of the month that the job should execute on. Must be between 1 and 31.")
  @maxItems(31)
  monthDays?: int32[];

  @doc("Occurrences of days within a month.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  monthlyOccurrences?: AdvancedScheduleMonthlyOccurrence[];
}

@doc("Week days.")
union WeekDay {
  @doc("Week day")
  Sunday: "Sunday",

  @doc("Week day")
  Monday: "Monday",

  @doc("Week day")
  Tuesday: "Tuesday",

  @doc("Week day")
  Wednesday: "Wednesday",

  @doc("Week day")
  Thursday: "Thursday",

  @doc("Week day")
  Friday: "Friday",

  @doc("Week day")
  Saturday: "Saturday",

  string,
}

@doc("Advanced schedule monthly occurrence.")
model AdvancedScheduleMonthlyOccurrence {
  @doc("Occurrence of the week within the month. Must be between 1 and 5.")
  @minValue(1)
  @maxValue(5)
  occurrence: int32;

  @doc("Day of the week.")
  day: WeekDay;
}

// Generic object / unknown / Record<unknown> is not the one we want to use here. Hence adding this model.
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
@doc("A generic object which can contain anything.")
model Object {}

@armResourceOperations
@tag("Operation Status Interfaces")
interface OperationStatus {
  @doc("Returns the current status of an async operation.")
  @autoRoute
  get(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.Validate",

    ...LocationParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
