// // Not active, ignoring any updates. Use status details field to declare
// // what's actually being used instead
// ConfigNotInUse ConfigurationStatusEnum = "NotInUse"

// // Good, just in progress creating the resources
// InProgress ConfigurationStatusEnum = "InProgress"

// // Something is stuck waiting to be resolved, e.g. incorrect underlying
// // storage configuration.
// Pending ConfigurationStatusEnum = "Pending"

// // The configuration is running and in use
// Running ConfigurationStatusEnum = "Running"

// // The configuration is terminating
// Terminating ConfigurationStatusEnum = "Terminating"

// // The configuration is upgrading
// Updating ConfigurationStatusEnum = "Updating"

// // We can't determine the status of the configuration
// Unknown ConfigurationStatusEnum = "Unknown"

@doc("provisioningState")
union provisioningState {
  @doc("Succeeded")
  Succeeded: "Succeeded",

  @doc("Failed")
  Failed: "Failed",

  @doc("Canceled")
  Canceled: "Canceled",

  @doc("ConfigNotInUse")
  ConfigNotInUse: "NotInUse",

  @doc("InProgress")
  InProgress: "InProgress",

  @doc("Pending")
  Pending: "Pending",

  @doc("Running")
  Running: "Running",

  @doc("Terminating")
  Terminating: "Terminating",

  @doc("Updating")
  Updating: "Updating",

  @doc("Unknown")
  Unknown: "Unknown",

  string,
}
