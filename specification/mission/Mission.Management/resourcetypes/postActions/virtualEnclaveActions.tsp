@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;
@doc("Request to the action call to set enclave maintenance mode.")
model SetEnclaveMaintenanceModeRequest {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("New enclave maintenance mode configuration.")
  maintenanceModeConfiguration: MaintenanceModeConfigurationPatchModel;
}

@doc("Request to the action call to set enclave role assignments.")
model SetEnclaveRoleAssignmentsRequest {
  @doc("List of Role Assignments")
  @OpenAPI.extension("x-ms-identifiers", #[])
  enclaveRoleAssignments?: RoleAssignmentItem[];
}

@doc("Request to the action call to update enclave subnets.")
model SetEnclaveSubnetsRequest {
  @doc("Updated enclave maintenance mode configuration.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  subnetConfigurations: SubnetConfiguration[];
}
