import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service({
    title: "PureStorage.Krypton", 
    version: "2023-06-01-preview",
})
@versioned(PureStorage.Krypton.Versions)
namespace PureStorage.Krypton;

enum Versions {
    @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
    v1_preview: "2023-06-01-preview"
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Volume pool properties.")
model VolumePoolProperties {

    @doc("Sample field for testing.")
    sampleField: string;

    @visibility("read")
    @doc("Provisioning State of the resource")
    provisioningState?: ProvisioningState;
}

@doc("A volume pool resource.")
model VolumePool is TrackedResource<VolumePoolProperties> {
    @doc("Name of the volume pool.")
    @key("volumePoolName")
    @segment("volumePools")
    @path
    @visibility("read")
    @pattern("[a-z]+")
    name: string;
}

@armResourceOperations
interface VolumePools extends TrackedResourceOperations<VolumePool, VolumePoolProperties> {}

enum ProvisioningState {
    Succeeded,
    Failed,
    Canceled,
  }