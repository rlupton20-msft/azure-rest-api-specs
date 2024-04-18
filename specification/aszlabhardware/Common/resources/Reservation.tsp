import "../models/ReservationConstraints.tsp";
import "../models/ResourceManager.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Private.AszLabHardware;

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

@armResourceOperations
interface Reservations {
  get is ArmResourceRead<Reservation>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Reservation>;
  update is ArmResourcePatchSync<Reservation, ReservationProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Reservation>;
  listByResourceGroup is ArmResourceListByParent<Reservation>;
  listBySubscription is ArmListBySubscription<Reservation>;
}
