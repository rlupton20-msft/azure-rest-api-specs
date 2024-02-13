@doc("LabResource availability for reservation state.")
enum LabResourceAvailableForReservationState {
    @doc("The LabResource is not available for reservation.")
    NotAvailableForReservation,

    @doc("The LabResource is available for reservation.")
    AvailableForReservation,
}

@doc("LabResource reservation status.")
enum LabResourceReservationStatus {
    @doc("The LabResource is not reserved.")
    NotReserved,

    @doc("The LabResource is reserved.")
    Reserved,
}

@doc("LabResource maintenance request state.")
enum LabResourceMaintenanceRequestState {
    @doc("The LabResource is not requested for maintenance.")
    MaintenanceNotRequested,

    @doc("The LabResource is requested for maintenance.")
    MaintenanceRequested,

    @doc("The LabResource is required for maintenance.")
    MaintenanceRequired,
}

@doc("LabResource maintenance status.")
enum LabResourceMaintenanceStatus {
    @doc("The LabResource is not requested for maintenance.")
    MaintenanceNotRequested,

    @doc("The LabResource is pending a requested maintenance.")
    MaintenancePending,

    @doc("The LabResource is in maintenance.")
    InMaintenance,

    @doc("The LabResource is in exclusive access mode (not available for reservation).")
    ExclusiveAccess,
}
