import "./common.tsp";
import "./cloudValidation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Validate;

@doc("Validation Test Execution Plan")
@parentResource(CloudValidation)
model ValidationExecutionPlan
  is TrackedResource<ValidationExecutionPlanProperties> {
  ...ResourceNameParameter<ValidationExecutionPlan>;
}

@doc("Validation Test Execution Plan properties")
model ValidationExecutionPlanProperties {
  @doc("The description of the resource.")
  description?: string;

  @doc("URI where the configuration of the execution plan is defined.")
  planConfigurationUri?: string;

  @doc("""
    Entire execution plan configuration/manifest json.
    Either of URI or this property is mandatory while creating.
    In get, always return the entire json configuration.
    """)
  planConfigurationJson?: string;

  @doc("The health of the execution plan.")
  @visibility(Lifecycle.Read)
  health?: ExecutionPlanHealth;

  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ValidationExecutionPlanProvisioningState;

  @doc("The overall state of the resource.")
  overallState?: ValidationExecutionPlanOverallState;

  @doc("The state conditions of the resource.")
  @visibility(Lifecycle.Read)
  stateCondition?: StateCondition;
}

@doc("The execution plan resource provisioning state.")
@lroStatus
union ValidationExecutionPlanProvisioningState {
  ResourceProvisioningState,

  @doc("The resource is being provisioned.")
  Creating: "Creating",

  @doc("The resource is updating.")
  Updating: "Updating",

  @doc("The resource is being disabled.")
  Disabling: "Disabling",

  @doc("The resource is being deleted")
  Deleting: "Deleting",

  string,
}

@doc("The Overall states of the validation execution plan.")
union ValidationExecutionPlanOverallState {
  @doc("The resource is in draft state.")
  Draft: "Draft",

  @doc("The resource is in completed state.")
  Completed: "Completed",

  @doc("The resource is in enabled state.")
  Enabled: "Enabled",

  @doc("The resource is in disabled state.")
  Disabled: "Disabled",

  @doc("The resource is in suspended state.")
  Suspended: "Suspended",

  string,
}

@doc("The health of the execution plan.")
model ExecutionPlanHealth {
  @doc("The state of the execution plan.")
  state: ExecutionPlanHealthState;

  @doc("Gets or sets the execution plan error.")
  error?: Object;
}

@doc("The state of the execution plan.")
union ExecutionPlanHealthState {
  @doc("The execution plan is healthy.")
  Healthy: "Healthy",

  @doc("The execution plan is unhealthy.")
  Unhealthy: "Unhealthy",

  @doc("The execution plan is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The execution plan is unknown.")
  Unknown: "Unknown",

  string,
}

@armResourceOperations
@tag("Validation Test Execution Plan Interfaces")
interface ValidationExecutionPlans {
  @doc("Get a validation test execution plan")
  get is ArmResourceRead<ValidationExecutionPlan>;

  @doc("Create or update a validation test execution plan")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ValidationExecutionPlan>;

  @doc("Update a validation test execution plan")
  @parameterVisibility(Lifecycle.Update)
  update is ArmResourcePatchAsync<
    ValidationExecutionPlan,
    ValidationExecutionPlanProperties
  >;

  @doc("Delete a validation test execution plan")
  delete is ArmResourceDeleteWithoutOkAsync<ValidationExecutionPlan>;

  @doc("List validation test execution plans by resource group")
  listByResourceGroup is ArmResourceListByParent<
    ValidationExecutionPlan,
    Parameters = PaginationQueryParameters
  >;

  @doc("List validation test execution plans by subscription")
  listBySubscription is ArmListBySubscription<
    ValidationExecutionPlan,
    PaginationQueryParameters
  >;
}
