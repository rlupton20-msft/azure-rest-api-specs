using Azure.ResourceManager;
using TypeSpec.Versioning;

// This is a local TypeSpec namespace.
// It is transformed to Microsoft.AszLabHardware as a namespace for the models file and generated controllers source.
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Common.AszLabHardware;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
    ...ResourceProvisioningState,
    Provisioning,
    Deleting
}
