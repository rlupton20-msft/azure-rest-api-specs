import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("State of the UE.")
enum UeState {
  @doc("UE has been connected.")
  Connected,

  @doc("UE is idle.")
  Idle,

  @doc("UE has been detached.")
  Detached,

  @doc("UE has been deregistered.")
  Deregistered,

  @doc("UE state is unknown.")
  Unknown,
}

@doc("Basic UE Information Properties.")
model UeInfoPropertiesFormat {
  @doc("RAT Type")
  ratType: RatType;

  @doc("State of the UE.")
  ueState: UeState;

  @doc("List of DNN and UE IP addresses.")
  @minItems(1)
  ueIpAddresses?: DnnIpPair[];

  @doc("The timestamp of last list UEs call to the packet core (UTC).")
  lastReadAt?: utcDateTime;
}

@doc("DNN and UE IP address")
model DnnIpPair {
  @doc("Data network name")
  dnn?: Dnn;

  @doc("UE IP address")
  @extension("x-ms-client-flatten", true)
  ueIpAddress?: UeIpAddress;
}
