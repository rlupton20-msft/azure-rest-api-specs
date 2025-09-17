@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Request to the action call to set community maintenance mode.")
model SetCommunityMaintenanceModeRequest {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("New community maintenance mode configuration.")
  maintenanceModeConfiguration: MaintenanceModeConfigurationPatchModel;
}
