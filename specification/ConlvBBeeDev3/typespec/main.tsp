import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;
using Autorest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

@armProviderNamespace("Private.BbeeDev3")
@service({
  title: "Private.BbeeDev3",
  version: "2023-12-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.BbeeDev3;

interface Operations extends Azure.ResourceManager.Operations {}

// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource")
model ProvisioningResource is TrackedResource<ProvisioningResourceProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("provisioningResourceName")
  @segment("conlvProvisioningResources")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("The activating state")
  Activating,

  @doc("The updating state")
  Updating,

  @doc("The deleting state")
  Deleting,
}

@doc("Details of the EdgeProvisioning ProvisioningResource.")
model ProvisioningResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("The provisioning service endpoints")
  deviceEndpoints?: DeviceEndpoints;
}

@doc("Device endpoints.")
model DeviceEndpoints { // TODO: follow up with DP and PM on the definition of the endpoints for ignite
  @doc("The default endpoint")
  default: DeviceEndpoint,
}

@doc("The device endpoint")
model DeviceEndpoint {
  @doc("Description of the Endpoint")
  @visibility("read")
  description?: string;

  @doc("Hostname of the Endpoint")
  @visibility("read")
  hostname?: string;
}

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T> {
}

@armResourceOperations
interface EdgeProvisioningOpeartions {
  @autoRoute
  @doc("Create a {name}", TResource)
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  @armResourceCreateOrUpdate(TResource)
  @put
  op EdgeProvisioningResourceCreateOrUpdateAsync<
    TResource extends ArmResource,
    TBaseParameters = BaseParameters<TResource>
  >(
    ...ResourceInstanceParameters<TResource, TBaseParameters>,

    @doc("Resource create parameters.")
    @body
    resource: TResource,
  ): ResourceUpdatedResponse<TResource> | ArmCreatedResponse<TResource> | ErrorResponse;
}

@armResourceOperations
interface ConlvProvisioningResources {
  get is ArmResourceRead<ProvisioningResource>;
  createOrUpdate is EdgeProvisioningOpeartions.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningResource>;
  delete is ArmResourceDeleteSync<ProvisioningResource>;
  update is ArmResourcePatchSync<ProvisioningResource, ProvisioningResourceProperties>;
  listByResourceGroup is ArmResourceListByParent<ProvisioningResource>;
  listBySubscription is ArmListBySubscription<ProvisioningResource>;
}

// Child resource: provisioning policy
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning policy resource")
@parentResource(ProvisioningResource)
model ProvisioningPolicy is TrackedResource<ProvisioningPolicyProperties> {
  @doc("The name of the employee")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("provisioningPolicyName")
  @segment("provisioningPolicies")
  @path
  name: string;
}

@doc("Details of the ProvisioningService ProvisioningPolicy.")
model ProvisioningPolicyProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The priority of the policy. Should be greater than 0.")
  priority: int32; 
  // TODO: is priority required property. 
  // can we avoid requirement for uniquenes
  // how can the customer swap priority for policies 
  // alternate option1: Consider Provisioning Policy properties as an array
  // alternate option2: Keep the priority as separate concept outside of policy
  // Investigate options from other resources

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  allocations?: Array<AllocationRule>;

  @doc("The device provisioning rule.")
  provisioning: ProvisioningRule;
}

@doc("The authentication type for bootstrap.")
enum BootstrapAuthenticationType {
  @doc("The X509 authentication type.")
  X509,

  @doc("The discovery authentication type.")
  Discovery,
}

@doc("The authentication details for bootstrap")
model BootstrapAuthenticationDetails {
  @doc("The primary certificate")
  @secret
  primaryCert: string;

  @doc("The secondary certificate")
  @secret
  secondaryCert?: string;
}

@doc("The authentication rule for bootstrap")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule")
  type: BootstrapAuthenticationType;

  @doc("The authentication details")
  details?: BootstrapAuthenticationDetails;
  // TODO use discriminator for properties specific to a bootstrap auth type
}

@doc("Type of resource being provisioned")
enum ProvisioningResourceType {
  @doc("Azure device registry device")
  AzureIoTDevice,

  @doc("Arc enabled device.")
  ArcEnabledDevice,
}

@doc("The rule for Just-in-time connection")
model JitRule {
  @minLength(1)
  @doc("The region")
  region: string; // TODO: checkout the location resource and see if we can use it here

  //...SubscriptionIdParameter;
  @minLength(1)
  @doc("The ID of the target subscription.")
  subscriptionId: string;

  //...ResourceGroupParameter;
  @minLength(1)
  @maxLength(90)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @doc("The name of the resource group. The name is case insensitive.")
  resourceGroupName: string;
}

@doc("Type of the endpoint")
enum EndpointType {
  @doc("Azure event grid broker")
  AzureEventGridBroker,

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Endpoint")
//@discriminator("type")
model AllocationEndpoint {
  @doc("Name of the endpoint")
  name: string;

  @doc("Resource id of the endpoint")
  resourceId: string;

  //@doc("Host name of the endpoint")
  //hostName?: string;

  @doc("Weight of the endpoint")
  weight?: float64;

  @doc("Region of the endpoint")
  region?: string;
}

// backup option: TODO - follow up with RPAAS on stackoverflow
//@doc("Geo-based endpoint")
//model GeoBasedEndpoint extends AllocationEndpoint {
//  @doc("Default value of discriminator")
//  type: "GeoBased";

//  @doc("Region of the endpoint")
//  region: string;
//}

//@doc("Weighted endpoint")
//model WeightedEndpoint extends AllocationEndpoint {
//  @doc("Default value of discriminator")
//  type: "Weighted";

//  @doc("Weight of the endpoint")
//  weight: float64;
//}

@doc("Type of allocation rule")
enum AllocationType {
  @doc("Static allocation of a single endpoint.")
  Static,

  @doc("Allocation based on geo-location.")
  GeoBased,

  @doc("Allocation based on weight.")
  Weighted,
}

@doc("The allocation rule")
model AllocationRule {
  @doc("Name of the allocation rule")
  name: string;

  @doc("Type of the allocation rule")
  type: AllocationType; // TODO: confirm with PMs on the types to have

  @doc("Type of endpoint")
  endpointType: EndpointType;

  @doc("List of endpoints")
  @extension("x-ms-identifiers", ["name"])
  endpoints?: Array<AllocationEndpoint>;

  // Option 1: use 2 arrays- Array<allocationProperties>, Array<endpointProperties>
  // index based or something similar to allow customers to provide input for allocation & endpoint type
  // Option 2: move the type inside the properties and enforce type restrictions for the array (homogenous)
  // TOODO Roopesh to circle back
  // ARM question: optional approach: having "weightedEndpoints" and "geoBasedEndpoints" separately with solid types
}

@doc("The identity info to return to device")
model DeviceIdentityInfo {
  @doc("If uuid need to be returned")
  uuid: boolean;

  @doc("If accessTokenUrl need to be returned")
  accessTokenUrl: boolean;

  @doc("If externalDeviceId need to be returned")
  externalDeviceId: boolean;
}

// TODO: Check with Krishna - Follow-up whether we want to expose this to the customer
@doc("Certificate issuance configurations")
model CertificateIssuanceRule {
  @doc("ICA - IntermediateCertificateAuthority name")
  intermediateCertificateAuthority: string; // TODO: find out who would set up this info customer or rp

  @doc("Cert renewal interval")
  renewalInterval: int32; // TODO: findout the unit of the interval, findout if there is a default value
}

@doc("The information related to device identity")
model IdentityInfo {
  @doc("Certificate issuance settings")
  certificateIssuance?: CertificateIssuanceRule; // For PKI

  @doc("Device template id")
  deviceTemplateId?: string;

  @doc("AAD group name for static group")
  staticGroup?: string;

  @doc("The identity info to return to device")
  identityInfoForDevice?: DeviceIdentityInfo; // TODO check with Adarsh,Sekhar if this supports both HCI and ADR scenario
}

@doc("The provisioning rule")
model ProvisioningRule {
  @doc("Type of the resource being provisioned")
  type: ProvisioningResourceType;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Identity information")
  identityInfo?: IdentityInfo; 

  @doc("Resource metadata")
  @maxLength(200)
  resourceMetadata?: string; // for customer to label the devices
}

@armResourceOperations
interface ProvisioningPolicies {
  get is ArmResourceRead<ProvisioningPolicy>;
  createOrUpdate is EdgeProvisioningOpeartions.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningPolicy>;
  delete is ArmResourceDeleteSync<ProvisioningPolicy>;
  update is ArmResourcePatchSync<ProvisioningPolicy, ProvisioningPolicyProperties>;
  listByParent is ArmResourceListByParent<ProvisioningPolicy>;
}