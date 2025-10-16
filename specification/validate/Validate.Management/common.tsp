using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Validate;

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

    ...LocationResourceParameter,
    ...Azure.ResourceManager.Foundations.OperationIdParameter,
  ): ArmResponse<OperationStatusResult> | ErrorResponse;
}

@@segment(OperationStatus.get::parameters.operationId, "operationStatuses");
