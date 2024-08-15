using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.AszLabHardware;

@doc("AszLabHardware api versions")
enum Versions {
  @doc("2024-06-01-preview api version")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2024-06-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@lroStatus
union ProvisioningState {
  @doc("Resource has been created.")
  Succeeded: "Succeeded",

  @doc("Resource creation failed.")
  Failed: "Failed",

  @doc("Resource creation was canceled.")
  Canceled: "Canceled",

  @doc("Resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",

  @doc("Resource work has been accepted")
  Accepted: "Accepted",

  string,
}
