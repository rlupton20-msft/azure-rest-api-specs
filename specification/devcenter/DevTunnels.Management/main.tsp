import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace
@service({
  title: "Azure Dev Tunnels",
})
@versioned(Versions)
namespace Microsoft.DevCenter;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Dev Tunnels API Verisons")
enum Versions {
  @doc("Dev Tunnels API Version 2024-02-06-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_02_06_preview: "2024-02-06-preview",
}

@doc("Provisioning state enum")
enum ProvisioningState {
  @doc("The operation succeeded")
  Succeeded,

  @doc("The operation failed")
  Failed,

  @doc("The operation was canceled")
  Canceled,

  @doc("A delete operation is in progress")
  Deleting,

  @doc("A provisioning operation is in progress")
  Provisioning,
}

model Project
  is TrackedResource<{
    @doc("The provisioning state of the project")
    @visibility("read")
    provisioningState?: ProvisioningState;
  }> {
  @key("projectName")
  @segment("projects")
  @doc("The name of the project")
  @visibility("read")
  @path
  name: string;
}

@doc("A Tunnel Domain resource")
@parentResource(Project)
model TunnelDomainResource is TrackedResource<TunnelDomainProperties> {
  @key("domainName")
  @segment("tunnelDomains")
  @doc("The name of the Tunnel Domain")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  ...EntityTag;
}

@doc("The properties of TunnelDomain")
model TunnelDomainProperties {
  @doc("Cluster ID where the TunnelDomain resides, used for data-plane operations")
  @visibility("read")
  clusterId?: string;

  @doc("The provisioning state of the domain")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface TunnelDomains {
  get is ArmResourceRead<TunnelDomainResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TunnelDomainResource>;
  update is ArmResourcePatchSync<TunnelDomainResource, TunnelDomainProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<TunnelDomainResource>;
  listByParent is ArmResourceListByParent<TunnelDomainResource>;
}
