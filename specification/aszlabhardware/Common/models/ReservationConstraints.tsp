@doc("Details of the AszLabHw Reservation constraints.")
model ReservationConstraints {
    @visibility("read","create", "update")
    @doc("The asset tags of the servers to be reserved.")
    assetTags: string[];
}