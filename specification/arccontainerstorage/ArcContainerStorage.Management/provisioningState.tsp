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

@doc("Provisioning state of the resource")
union provisioningState {
  @doc("Succeeded creation of resources")
  Succeeded: "Succeeded",

  @doc("Failed to create resources")
  Failed: "Failed",

  @doc("Canceled creation of resources")
  Canceled: "Canceled",

  @doc("Config is not in use")
  ConfigNotInUse: "NotInUse",

  @doc("InProgress creation of resources")
  InProgress: "InProgress",

  @doc("Pending waiting for controllers")
  Pending: "Pending",

  @doc("Running resources")
  Running: "Running",

  @doc("Terminating resources")
  Terminating: "Terminating",

  @doc("Updating resources")
  Updating: "Updating",

  @doc("Unknown state (possible error)")
  Unknown: "Unknown",

  string,
}

@doc("Provisioning status of the resource")
model ProvisioningStatus {
  @doc("The status string of the provisioning status.")
  status: string;

  @doc("The operation ID of the provisioning status.")
  operationId: string;
}
