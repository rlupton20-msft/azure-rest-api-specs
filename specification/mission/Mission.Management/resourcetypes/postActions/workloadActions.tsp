@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;
@doc("Request to the action call to set workload role assignments on the enclave.")
model SetWorkloadRoleAssignmentsRequest {
  @doc("List of Role Assignments")
  @OpenAPI.extension("x-ms-identifiers", #[])
  workloadRoleAssignments?: RoleAssignmentItem[];
}
