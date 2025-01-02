@doc("provisioningState")
union provisioningState {
  @doc("Succeeded")
  Succeeded: "Succeeded",

  @doc("Failed")
  Failed: "Failed",

  @doc("Canceled")
  Canceled: "Canceled",

  string,
}
