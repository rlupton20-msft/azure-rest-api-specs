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
namespace Private.DevTunnels;

@doc("Dev Tunnels API Verisons")
enum Versions {
  @doc("Dev Tunnels API Version 2023-05-23-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_05_23_preview: "2023-05-23-preview",

  @doc("Dev Tunnels API Version 2023-11-17-preview")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2023_11_17_preview: "2023-11-17-preview",
}

interface Operations extends Azure.ResourceManager.Operations {
  @tag("CheckNameAvailability")
  checkName is checkGlobalNameAvailability;
}

@doc("Provisioning state enum")
enum ProvisioningState {
  @doc("The operation succeeded")
  Succeeded,

  @doc("The operation failed")
  Failed,

  @doc("The operation was canceled")
  Canceled,

  @added(Versions.v2023_11_17_preview)
  @doc("A delete operation is in progress")
  Deleting,

  @added(Versions.v2023_11_17_preview)
  @doc("A provisioning operation is in progress")
  Provisioning,
}

@doc("The properties of TunnelPlan")
@removed(Versions.v2023_11_17_preview)
model TunnelPlanProperties {
  @doc("The billing tier for the plan")
  billingTier: string;

  @doc("Cluster ID where the TunnelPlan resides, used for data-plane operations")
  @visibility("read")
  clusterId?: string;

  @doc("The provisioning state of the plan")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("A Tunnel Plan resource")
@removed(Versions.v2023_11_17_preview)
model TunnelPlanResource is TrackedResource<TunnelPlanProperties> {
  @key("planName")
  @segment("tunnelPlans")
  @doc("The name of the Tunnel Plan")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  ...EntityTag;
}

@doc("The response to a getToken request")
@removed(Versions.v2023_11_17_preview)
model GetTokenResponse {
  @doc("The TunnelPlan token")
  token: string;
}

@armResourceOperations
@removed(Versions.v2023_11_17_preview)
interface TunnelPlans {
  @autoRoute
  @armResourceAction(TResource)
  @post
  @doc("POST ARM resource action with no body")
  ArmResourceActionNoBodySync<
    TResource extends ArmResource,
    TResponse extends {},
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,
  ): ArmResponse<TResponse> | ErrorResponse;

  get is ArmResourceRead<TunnelPlanResource>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<TunnelPlanResource>;
  update is ArmResourcePatchSync<TunnelPlanResource, TunnelPlanProperties>;
  delete is ArmResourceDeleteSync<TunnelPlanResource>;
  listByResourceGroup is ArmResourceListByParent<TunnelPlanResource>;
  listBySubscription is ArmListBySubscription<TunnelPlanResource>;
  @doc("Get a Tunnel Plan token")
  listToken is TunnelPlans.ArmResourceActionNoBodySync<
    TunnelPlanResource,
    GetTokenResponse
  >;
}

@doc("The properties of a billing tier")
@removed(Versions.v2023_11_17_preview)
model BillingTierProperties {
  @doc("Description of the billing tier")
  description: string;

  @doc("The provisioning state of the plan")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@subscriptionResource
@removed(Versions.v2023_11_17_preview)
model BillingTierResource is ProxyResource<BillingTierProperties> {
  @doc("Billing Tier Name")
  @visibility("read")
  @key
  @path
  @segment("billingTiers")
  name: string;
}

@removed(Versions.v2023_11_17_preview)
@armResourceOperations(BillingTierResource)
interface BillingTiers
  extends ResourceListBySubscription<BillingTierResource> {}

@doc("A Tunnel Domain resource")
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

  @doc("The provisioning state of the plan")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
@added(Versions.v2023_11_17_preview)
interface TunnelDomains {
  get is ArmResourceRead<TunnelDomainResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TunnelDomainResource>;
  update is ArmResourcePatchSync<TunnelDomainResource, TunnelDomainProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<TunnelDomainResource>;
  listByResourceGroup is ArmResourceListByParent<TunnelDomainResource>;
  listBySubscription is ArmListBySubscription<TunnelDomainResource>;
}
