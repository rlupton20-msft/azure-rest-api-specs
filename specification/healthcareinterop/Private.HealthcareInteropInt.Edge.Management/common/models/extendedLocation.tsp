import "@azure-tools/typespec-azure-resource-manager";

namespace Private.HealthcareInteropInt;

@doc("The extended location.")
model ExtendedLocation {
  @doc("The extended location type.")
  type: string;

  @doc("The extended location name.")
  name: string;
}
