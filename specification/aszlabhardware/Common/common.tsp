using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
namespace Common.AszLabHardware;

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-10-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@lroStatus
enum ProvisioningState {
    ...ResourceProvisioningState,
    Provisioning,
    Updating,
    Deleting,
    Accepted,
}
