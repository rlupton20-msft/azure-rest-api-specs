import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace GitHub.Network;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the managed application.")
enum ProvisioningState {
  @doc("The provisioning of the resource failed.")
  Failed,

  @doc("The resource was provisioned successfully.")
  Succeeded,

  @doc("The provisioning of the resource was cancelled.")
  Canceled,

  @doc("The resource provisioning is in progress.")
  Accepted,
}

@doc("NetworkSettings resource-specific properties.")
model NetworkSettingsResourceProperties {
  @doc("Specifies a subnet ID for vnet-injection.")
  subnetId?: string;

  @doc("Specifies the GitHub organization (enterprise) ID associated to the Azure subscription.")
  organizationId?: string;

  @doc("The managed application provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
