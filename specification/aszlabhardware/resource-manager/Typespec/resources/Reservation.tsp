import "../main.tsp";
import "../models/ReservationConstraints.tsp";
import "../models/ResourceManager.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A physical computer which can be reserved for use by a user")
model Reservation is TrackedResource<ReservationProperties> {
    @doc("The name of the reservation")
    @pattern("^[a-zA-Z0-9-]{3,24}$")
    @key("reservationName")
    @segment("reservations")
    @path
    name: string;
}

@doc("Details of the AszLabHw Reservation.")
model ReservationProperties {
    @visibility("read")
    @doc("The current status of the GoalState")
    resourceManager?: ResourceManager;

    @visibility("read")
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;

    @visibility("read","create", "update")
    @doc("The set of constraints to create the reservation.")
    reservationConstraints: ReservationConstraints;
}

@armResourceOperations(Reservation)
interface Reservations extends TrackedResourceOperations<Reservation, ReservationProperties>{}
