@doc("Resource maintenance status.")
enum UserLabResourceMaintenanceStatus {
    @doc("The Resource is not requested for maintenance.")
    MaintenanceNotRequested,

    @doc("The Resource has been requested for maintenance.")
    MaintenanceRequested,

    @doc("The Resource is in maintenance.")
    InMaintenance,

    @doc("The Resource is in exclusive access mode (not available for reservation).")
    ExclusiveAccess,
}
