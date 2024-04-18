@doc("Resource maintenance status.")
union UserLabResourceMaintenanceStatus {
    @doc("The Resource is not requested for maintenance.")
    MaintenanceNotRequested: "MaintenanceNotRequested",

    @doc("The Resource has been requested for maintenance.")
    MaintenanceRequested: "MaintenanceRequested",

    @doc("The Resource is in maintenance.")
    InMaintenance: "InMaintenance",

    @doc("The Resource is in exclusive access mode (not available for reservation).")
    ExclusiveAccess: "ExclusiveAccess",

    string,
}
