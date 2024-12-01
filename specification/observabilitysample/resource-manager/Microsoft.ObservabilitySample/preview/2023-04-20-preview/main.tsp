import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "ObservabilitySample",
  version: "2023-04-20-preview",
})
@doc("Contoso Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.ObservabilitySample;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("A ObservabilitySample resource")
model Monitor is TrackedResource<MonitorProperties> {
  @doc("Name of Monitor")
  @key("monitorName")
  @path
  @segment("monitors")
  name: string;
}

@doc("Monitor properties")
model MonitorProperties {
  @doc("Age of Monitor")
  age?: int32;

  @doc("City of Monitor")
  city?: string;

  @doc("Profile of Monitor")
  @format("base64Url")
  profile?: bytes;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Monitors extends TrackedResourceOperations<Monitor, MonitorProperties> {}

@lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}
