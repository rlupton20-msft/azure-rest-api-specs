import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./resourcetypes/community/community.tsp";
import "./resourcetypes/virtualEnclave/virtualenclave.tsp";
import "./resourcetypes/workload/workload.tsp";
import "./resourcetypes/endpoint/endpoint.tsp";
import "./resourcetypes/internalConnection/internalConnection.tsp";
import "./resourcetypes/externalConnection/externalConnection.tsp";
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";
import "./resourcetypes/transitHub/transitHub.tsp";
import "./resourcetypes/enclaveConnection/enclaveConnection.tsp";
import "./resourcetypes/communityEndpoint/communityEndpoint.tsp";
import "./resourcetypes/enclaveEndpoint/enclaveEndpoint.tsp";
import "./resourcetypes/postActions/approvalcallback.tsp";
import "./resourcetypes/approvals/approvals.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

/** Compliant create or update template */
/**
 * A long-running resource CreateOrUpdate (PUT)
 * @template TResource the resource being patched
 * @template TBaseParameters Optional. Allows overriding the operation parameters
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-outside-interface" "This is a valid template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a valid template"
@autoRoute
@doc("Create a {name}", TResource)
@OpenAPI.extension("x-ms-long-running-operation", true)
@OpenAPI.extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "azure-async-operation",
  }
)
@armResourceCreateOrUpdate(TResource)
@put
op ArmResourceCreateOrUpdateAsync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("Resource create parameters.")
  @bodyRoot
  resource: TResource,
): ArmUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
  is ArmResponse<TResource>;

@doc("Community Model Resource")
model CommunityResource is TrackedResource<CommunityProperties> {
  @key("communityName")
  @segment("communities")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the communityResource Resource")
  name: string;
}

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;
}

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the workloadResource Resource")
  name: string;
}

@doc("Endpoint Model Resource")
@parentResource(EnclaveResource)
model EndpointResource is TrackedResource<EndpointProperties> {
  @key("endpointName")
  @segment("endpoints")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the endpointResource Resource")
  name: string;
}

@doc("Describes an Internal Connection.")
model InternalConnection is TrackedResource<InternalConnectionProperties> {
  @key("internalConnectionName")
  @segment("internalConnections")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the internal connection.")
  @path
  name: string;
}

@doc("Describes an External Connection.")
model ExternalConnection is TrackedResource<ExternalConnectionProperties> {
  @key("externalConnectionName")
  @segment("externalConnections")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the external connection.")
  @path
  name: string;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("TransitHub Model Resource")
@parentResource(CommunityResource)
model TransitHubResource is TrackedResource<TransitHubProperties> {
  @key("transitHubName")
  @segment("transitHubs")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the TransitHub Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("EnclaveConnection Model Resource")
model EnclaveConnectionResource
  is TrackedResource<EnclaveConnectionProperties> {
  @key("enclaveConnectionName")
  @segment("enclaveConnections")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Connection Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("EnclaveEndpoint Model Resource")
@parentResource(EnclaveResource)
model EnclaveEndpointResource is TrackedResource<EnclaveEndpointProperties> {
  @key("enclaveEndpointName")
  @segment("enclaveEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Endpoint Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("CommunityEndpoint Model Resource")
@parentResource(CommunityResource)
model CommunityEndpointResource
  is TrackedResource<CommunityEndpointProperties> {
  @key("communityEndpointName")
  @segment("communityEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the Community Endpoint Resource")
  name: string;
}

@doc("Approvals Model Resource")
model ApprovalsResource is ExtensionResource<ApprovalsProperties> {
  @key("approvalsName")
  @segment("approvals")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the approvals resource.")
  name: string;
}

@doc("Workload Interface")
@armResourceOperations
interface Workload {
  get is ArmResourceRead<WorkloadResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<WorkloadResource>;
  update is ArmResourcePatchAsync<WorkloadResource, WorkloadProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<WorkloadResource>;
  listByParent is ArmResourceListByParent<WorkloadResource>;
  listBySubscription is ArmListBySubscription<WorkloadResource>;
}

@doc("Endpoint Interface")
@armResourceOperations
interface Endpoint {
  get is ArmResourceRead<EndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EndpointResource>;
  update is ArmResourcePatchAsync<EndpointResource, EndpointProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<EndpointResource>;
  listByParent is ArmResourceListByParent<EndpointResource>;
  listBySubscription is ArmListBySubscription<EndpointResource>;
}

@doc("Virtual Enclave Interface")
@armResourceOperations
interface VirtualEnclave {
  get is ArmResourceRead<EnclaveResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveResource>;
  update is ArmResourcePatchAsync<EnclaveResource, VirtualEnclaveProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveResource>;
  listByParent is ArmResourceListByParent<EnclaveResource>;
  listBySubscription is ArmListBySubscription<EnclaveResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Virtual Enclave is available.")
  @armResourceAction(EnclaveResource)
  @post
  @removed(Microsoft.Mission.Versions.v2024_06_01_preview)
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<EnclaveResource>,

    @doc("Check IP Address Space request body.")
    @bodyRoot
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

@doc("Community Interface")
@armResourceOperations
interface Community {
  get is ArmResourceRead<CommunityResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityResource>;
  update is ArmResourcePatchAsync<CommunityResource, CommunityProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<CommunityResource>;
  listByParent is ArmResourceListByParent<CommunityResource>;
  listBySubscription is ArmListBySubscription<CommunityResource>;

  @autoRoute
  @doc("Checks that the IP Address Space to be allocated for this Community is available.")
  @armResourceAction(CommunityResource)
  @post
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  checkAddressSpaceAvailability(
    ...ResourceInstanceParameters<CommunityResource>,

    @doc("Check IP Address Space request body.")
    @bodyRoot
    checkAddressSpaceAvailabilityRequest: CheckAddressSpaceAvailabilityRequest,
  ): ArmResponse<CheckAddressSpaceAvailabilityResponse> | ErrorResponse;
}

@doc("Internal Connections")
@armResourceOperations
interface InternalConnections {
  get is ArmResourceRead<InternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<InternalConnection>;
  update is ArmResourcePatchAsync<
    InternalConnection,
    InternalConnectionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<InternalConnection>;
  listByParent is ArmResourceListByParent<InternalConnection>;
  listBySubscription is ArmListBySubscription<InternalConnection>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("TransitHub Interface")
@armResourceOperations
interface TransitHub {
  get is ArmResourceRead<TransitHubResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<TransitHubResource>;
  update is ArmResourcePatchAsync<TransitHubResource, TransitHubProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<TransitHubResource>;
  listByParent is ArmResourceListByParent<TransitHubResource>;
  listBySubscription is ArmListBySubscription<TransitHubResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Connection Interface")
@armResourceOperations
interface EnclaveConnection {
  get is ArmResourceRead<EnclaveConnectionResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveConnectionResource>;
  update is ArmResourcePatchAsync<
    EnclaveConnectionResource,
    EnclaveConnectionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveConnectionResource>;
  listByParent is ArmResourceListByParent<EnclaveConnectionResource>;
  listBySubscription is ArmListBySubscription<EnclaveConnectionResource>;

  @doc("Upon getting desired approvals this faciliates actions on approvals")
  @armResourceAction(EnclaveConnectionResource)
  @added(Microsoft.Mission.Versions.v2024_06_01_preview)
  approvalCallback is ArmResourceActionAsync<EnclaveConnectionResource, ApprovalCallbackRequest, ApprovalCallbackResponse>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Enclave Endpoint Interface")
@armResourceOperations
interface EnclaveEndpoints {
  get is ArmResourceRead<EnclaveEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EnclaveEndpointResource>;
  update is ArmResourcePatchAsync<
    EnclaveEndpointResource,
    EnclaveEndpointProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<EnclaveEndpointResource>;
  listByParent is ArmResourceListByParent<EnclaveEndpointResource>;
  listBySubscription is ArmListBySubscription<EnclaveEndpointResource>;
}

@added(Microsoft.Mission.Versions.v2023_08_01_preview)
@doc("Community Endpoint Interface")
@armResourceOperations
interface CommunityEndpoints {
  get is ArmResourceRead<CommunityEndpointResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CommunityEndpointResource>;
  update is ArmResourcePatchAsync<
    CommunityEndpointResource,
    CommunityEndpointProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<CommunityEndpointResource>;
  listByParent is ArmResourceListByParent<CommunityEndpointResource>;
  listBySubscription is ArmListBySubscription<CommunityEndpointResource>;
}

@doc("External Connections")
@armResourceOperations
interface ExternalConnections {
  get is ArmResourceRead<ExternalConnection>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ExternalConnection>;
  update is ArmResourcePatchAsync<
    ExternalConnection,
    ExternalConnectionProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<ExternalConnection>;
  listByParent is ArmResourceListByParent<ExternalConnection>;
  listBySubscription is ArmListBySubscription<ExternalConnection>;
}

@doc("Approvals Interface")
@armResourceOperations
interface Approvals {
  get is ArmResourceRead<ApprovalsResource>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ApprovalsResource>;
  delete is ArmResourceDeleteWithoutOkAsync<ApprovalsResource>;
  listByParent is ArmResourceListByParent<ApprovalsResource>;
}