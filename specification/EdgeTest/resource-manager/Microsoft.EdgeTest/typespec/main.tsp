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

@armProviderNamespace("Microsoft.EdgeTest")
@service({
  title: "Microsoft.EdgeTest",
  version: "2021-08-01-preview",
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.EdgeTest;

interface Operations extends Azure.ResourceManager.Operations {}

// Root-level tracked resource: provisioning resource
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning resource.")
model ProvisioningResource is TrackedResource<ProvisioningResourceProperties> {
  @doc("The name of the Provisioning Resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("provisioningResourceName")
  @segment("provisioningResources")
  @path
  name: string;

  // TODO resource SKU @Jesus to define
}

@doc("Details of the EdgeProvisioning ProvisioningResource.")
model ProvisioningResourceProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;

  @visibility("read")
  @doc("The provisioning service endpoints.")
  deviceEndpoints?: DeviceEndpoints;
}

@doc("Device endpoints.")
model DeviceEndpoints { // TODO: follow up with DP and PM on the definition of the endpoints for ignite
  @doc("The default endpoint.")
  @visibility("read")
  default?: DeviceEndpoint,
}

@doc("The device endpoint.")
model DeviceEndpoint {
  @doc("Hostname of the Endpoint.")
  @visibility("read")
  hostname?: string;
}

@doc("Resource create or update operation completed successfully.")
model ResourceUpdatedResponse<T> is ArmResponse<T> {
}

@armResourceOperations
interface EdgeProvisioningOperations {
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
interface ProvisioningResources {
  get is ArmResourceRead<ProvisioningResource>;
  createOrUpdate is EdgeProvisioningOperations.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningResource>;
  delete is ArmResourceDeleteSync<ProvisioningResource>;
  update is ArmResourcePatchSync<ProvisioningResource, ProvisioningResourceProperties>;
  listByResourceGroup is ArmResourceListByParent<ProvisioningResource>;
  listBySubscription is ArmListBySubscription<ProvisioningResource>;
}

// Child resource: provisioning policy
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A provisioning policy resource.")
@parentResource(ProvisioningResource)
model ProvisioningPolicy is TrackedResource<ProvisioningPolicyProperties> {
  @doc("The name of the Provisioning Policy tracked resource.")
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
  provisioningState?: ResourceProvisioningState;

  @doc("The bootstrap authentication rule.")
  bootstrapAuthentication: BootstrapAuthenticationRule;

  @doc("Allocation rules.")
  @extension("x-ms-identifiers", ["name"])
  @maxItems(1)
  allocations?: Array<AllocationRule>;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Further details about the policy resource")
  resourceDetails: ProvisioningPolicyResourceDetails;
}

@doc("Type of resource being provisioned.")
enum ProvisioningResourceType {
  @doc("Azure device registry device. Microsoft.DeviceRegistry/devices")
  DeviceRegistryDevice:"Microsoft.DeviceRegistry/devices",
  //DeviceRegistryDevice,
  // TODO another option is use value in double quotes. Try in ARM RPaas to finalize (Testing)

  @doc("Arc enabled device. Microsoft.HybridCompute/machines")
  HybridComputeMachine:"Microsoft.HybridCompute/machines",
  //HybridComputeMachine,
}

@doc("Common further details about the policy resource")
@discriminator("type")
model ProvisioningPolicyResourceDetails {
  @doc("Type of the resource being provisioned.")
  type: ProvisioningResourceType;
}

@doc("Details of the ProvisioningService Device Registry ProvisioningPolicy.")
model DeviceRegistryProvisioningPolicyResourceDetails extends ProvisioningPolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: ProvisioningResourceType.DeviceRegistryDevice;  

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo; 
  // make this property polymorphic based on ProvisioningResourceType.
  // The current definition of the identity Info is for ADR resource type.
  // AadIdentityInfo

  @doc("Resource metadata.")
  @maxLength(200)
  resourceMetadata?: string; // for customer to label the devices
}

@doc("Details of the ProvisioningService Discovery ProvisioningPolicy.")
model DiscoveryProvisioningPolicyResourceDetails extends ProvisioningPolicyResourceDetails {
  @doc("The policy resource type for device registry devices.")
  type: ProvisioningResourceType.HybridComputeMachine;
}

@doc("The authentication type for bootstrap.")
enum BootstrapAuthenticationType {
  @doc("The X509 authentication type.")
  X509,

  @doc("The discovery authentication type.")
  Discovery,
  // PM: how does user understand this auth type & the device behavior/requirements
  // TODO name confirmation with PMs
}

@doc("The authentication rule for bootstrap.")
@discriminator("type")
model BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType;
}

@doc("The x509-based authentication rule for bootstrapping.")
model X509BootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.X509;

  @doc("The primary certificate. B64 x509 cert")
  //@secret todo
  primaryCertificate: string;
  // TODO Tim - on any additional properties needed from user. example: root, chain, etc
  // Todo Adarsh/Tim, are there more details for x509s

  @doc("The secondary certificate.")
  //@secret todo
  secondaryCertificate?: string;
}

@doc("The Discovery-based authentication rule for bootstrapping.")
model DiscoveryBootstrapAuthenticationRule extends BootstrapAuthenticationRule {
  @doc("The type of authentication rule.")
  type: BootstrapAuthenticationType.Discovery;
}

@doc("The rule for Just-in-time connection.")
model JitRule {
  @doc("The priority of the policy. Should be greater than 0.")
  priority: int32; 
  // TODO: is priority required property. 
  // can we avoid requirement for uniquenes
  // how can the customer swap priority for policies 
  // alternate option1: Consider Provisioning Policy properties as an array
  // alternate option2: Keep the priority as separate concept outside of policy
  // Investigate options from other resources

  @minLength(1)
  @doc("The region.")
  region: string; // TODO: checkout the location resource and see if we can use it here

  //...SubscriptionIdParameter;
  @minLength(1)
  @doc("The ID of the target subscription.")
  subscriptionId: string;

  //...ResourceGroupParameter;
  @minLength(1)
  @maxLength(90)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @doc("The case insensitive name of the target resource group.")
  resourceGroupName: string;
}

@doc("Type of the endpoint.")
enum EndpointType {
  @doc("Azure event grid broker.")
  MicrosoftEventGridNamespace:"Microsoft.EventGrid/namespaces",

  //@doc("Azure storage")
  //AzureStorage,
}

@doc("Type of allocation rule.")
enum AllocationType {
  @doc("Static allocation of a single endpoint.")
  Static,
  // This is simpler version for Weighted with 1 endpoint in the array
  // PM input needed

  @doc("Allocation based on geo-location.")
  GeoBased,

  @doc("Allocation based on weight.")
  Weighted,
}

@doc("The allocation rule.")
@discriminator("type")
model AllocationRule {
  @doc("Name of the allocation rule.")
  name: string;

  @doc("Type of endpoint.")
  endpointType: EndpointType;

  @doc("Type of the allocation rule.")
  type: AllocationType;
}

// TODO name in allocation endpoint Geo-based vs latency-based
@doc("GeoBased allocation endpoint.")
model GeoBasedAllocationEndpoint {
  @doc("Name of the endpoint.")
  name: string;

  @doc("Resource id of the endpoint.")
  resourceId: string;

  @doc("host name of the endpoint.")
  hostName: string;

  @doc("Region of the endpoint.")
  region: string;
}

@doc("Weighted allocation endpoint.")
model WeightedAllocationEndpoint {
  @doc("Name of the endpoint.")
  name: string;

  @doc("Resource id of the endpoint.")
  resourceId: string;

  @doc("host name of the endpoint.")
  hostName: string;

  @doc("Weight of the endpoint.")
  weight: float64;
}

@doc("Static allocation endpoint.")
model StaticAllocationEndpoint {
  @doc("Name of the endpoint.")
  name: string;

  @doc("Resource id of the endpoint.")
  resourceId: string;

  @doc("host name of the endpoint.")
  hostName: string;
}

@doc("The allocation rule for geoBased allocation type.")
model GeoBasedAllocationRule extends AllocationRule {
  @doc("GeoBased allocation type.")
  type: AllocationType.GeoBased;

  @doc("List of endpoints for geoBased allocation type.")
  @maxItems(10)
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  endpoints: Array<GeoBasedAllocationEndpoint>;
}

@doc("The allocation rule for weighted allocation type.")
model WeightedAllocationRule extends AllocationRule {
  @doc("weighted allocation type.")
  type: AllocationType.Weighted;

  @doc("List of endpoints for weighted allocation type.")
  @maxItems(10)
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  endpoints: Array<WeightedAllocationEndpoint>;
// todo no optional (to be tested)
}

@doc("The allocation rule for static allocation type.")
model StaticAllocationRule extends AllocationRule {
  @doc("Static allocation type.")
  type: AllocationType.Static;

  @doc("List of endpoints for static allocation type.")
  @maxItems(1)
  @minItems(1)
  @extension("x-ms-identifiers", ["name"])
  endpoints: Array<StaticAllocationEndpoint>;
}

@doc("The identity info to return to device.")
model DeviceIdentityInfo {
  @doc("If uuid need to be returned.")
  uuid: boolean;

  @doc("If accessTokenUrl need to be returned.")
  accessTokenUrl: boolean;

  @doc("If externalDeviceId need to be returned.")
  externalDeviceId: boolean;
}

@doc("Potential sources for cert issuance config.")
enum SourceType {
  @doc("From certificate signing request.")
  CSR,

  @doc("From the enrollment policy.")
  Policy,

  @doc("From the substitute.")
  Substitute
}

@doc("Supported key types.")
enum SupportedKeyType {
  @doc("Indicate the RSA key type.")
  RSA,

  @doc("Indicate the EC key type.")
  EC,
}

@doc("Supported extended key usages.")
enum SupportedExtendedKeyUsage {
  @doc("Client auth.")
  ClientAuth,

  @doc("Code signing.")
  CodeSigning,

  @doc("Email protection.")
  EmailProtection,

  @doc("Ipsec end system.")
  IpsecEndSystem,

  @doc("Ipsec tunnel.")
  IpsecTunnel,

  @doc("Ipsec user.")
  IpsecUser,

  @doc("Mac address.")
  MacAddress,

  @doc("Ocsp signing.")
  OcspSigning,

  @doc("Server auth.")
  ServerAuth,

  @doc("Smartcard logon.")
  SmartcardLogon,

  @doc("Time stamping.")
  TimeStamping
}

@doc("Supported curve types.")
enum SupportedCurveType {
  @doc("Indicate the NistP256 Curve Type.")
  NistP256,

  @doc("Indicate the NistP384 Curve Type.")
  NistP384,

  @doc("Indicate the NistP521 Curve Type.")
  NistP521,

  @doc("Indicate the Secp256K1 Curve Type.")
  Secp256K1,
}

@doc("Supported issuing authority.")
enum SupportedIssuingAuthority {
  @doc("First party cert issuance.")
  FirstParty
}

@doc("The configuration for setting up a CA.")
model CaConfig
{
  @doc("Name of the CA.")
  name: string;

  @doc("Certificate properties.")
  properties: CertificateProperties;
}

@doc("Certificate properties.")
model CertificateProperties
{
  @doc("Key type: RSA or EC.")
  keyType: SupportedKeyType;

  @doc("Key size for RSA key type.")
  keySize?: int32;

  @doc("Certificate subject.")
  subject: string;

  @doc("Certificate is valid not before this date. Format ISO8601")
  validityNotBefore: utcDateTime;

  @doc("Certificate is valid not after this date. Format ISO8601")
  validityNotAfter: utcDateTime;

  @doc("Extended key usage.")
  extendedKeyUsage?: Array<SupportedExtendedKeyUsage>;

  @doc("Curve type of EC.")
  curveType?: SupportedCurveType;
}

@doc("The configuration for setting up a policy.")
model CertPolicyConfig
{
  @doc("The validity period.")
  validityPeriod: ValidityPeriod;
}

@doc("The validity period for an enrollment policy.")
model ValidityPeriod
{
  @doc("Source of the value.")
  source: SourceType;

  @doc("Skew in minutes to account for the time on different computers not being in sync.")
  notBeforeSkewMinutes: int32;

  @doc("For calculation of the NotBefore date.")
  valueNotBeforeOffSetDays?: int32;

  @doc("For calculation of the NotAfter date.")
  valueValidityPeriodDays?: int32,

  @doc("Allowed not before offset in days.")
  allowedNotBeforeOffSetDays?: int32;

  @doc("Allowed validity period in days.")
  allowedValidityPeriodDays?: int32;
}

@doc("Certificate issuance configurations.")
model CertificateIssuanceRule {
  @doc("The type of authority for cert issuance.")
  issuingAuthority: SupportedIssuingAuthority; //enum, FirstParty, BYO

  @doc("The configuration to set up an ICA.")
  certificateAuthorityConfiguration: CaConfig; // set by the customers

  @doc("The enrollment policy configuration.")
  certificatePolicyConfiguration: CertPolicyConfig; // same type as the ica config

  @doc("Cert renewal interval.")
  renewalInterval: int32; // A number of percentage. An example for renewal interval is - renew at 80%
}

@doc("The information related to device identity.")
model IdentityInfo {
  //@doc("Certificate issuance settings.")
  //certificateIssuance?: CertificateIssuanceRule; // For PKI

  @doc("Device template id.")
  deviceTemplateId?: string;

  @doc("AAD group name for static group.")
  staticGroup?: string;

  @doc("The id of the devices Tenant.")
  deviceTenantId: string;
  //@doc("The identity info to return to device.")
  //identityInfoForDevice?: DeviceIdentityInfo; // TODO check with Adarsh,Sekhar if this supports both HCI and ADR scenario
}

@doc("The provisioning rule.")
model ProvisioningRule {
  @doc("Type of the resource being provisioned.")
  type: ProvisioningResourceType;

  @doc("Just-in-time rule to create the device resource.")
  jit?: JitRule;

  @doc("Identity information.")
  operationalIdentityInfo?: IdentityInfo; 

  @doc("Resource metadata.")
  @maxLength(200)
  resourceMetadata?: string; // for customer to label the devices
}

@armResourceOperations
interface ProvisioningPolicies {
  get is ArmResourceRead<ProvisioningPolicy>;
  createOrUpdate is EdgeProvisioningOperations.EdgeProvisioningResourceCreateOrUpdateAsync<ProvisioningPolicy>;
  delete is ArmResourceDeleteSync<ProvisioningPolicy>;
  update is ArmResourcePatchSync<ProvisioningPolicy, ProvisioningPolicyProperties>;
  listByParent is ArmResourceListByParent<ProvisioningPolicy>;
}

// Extension resource: device provisioning state

@singleton
@doc("The provisioning state of a device.")
model DeviceProvisioningState is ExtensionResource<DeviceProvisioningStateProperties> {
  @doc("The default DeviceProvisioningState, singleton extension resource used to represent the state of the device it extends.")
  @segment("deviceProvisioningStates")
  @key
  @path
  name: string;
}

@pattern("^/subscriptions/(.+?)/resourceGroups/(.+?)/providers/(.+?)/provisioningResources/(.+?)/provisioningPolicies/(.+)$")
scalar ProvisioningPolicyResourceId
  extends ResourceIdentifier<[
    {
      type: "Microsoft.EdgeTest/ProvisioningResources/ProvisioningPolicies",
    }
  ]>;

@doc("Details of the DeviceProvisioningState")
model DeviceProvisioningStateProperties {
  @doc("Unique identifier for the device. Allow alphanumeric and '-', '.', '_', ':' only. Last character can only be alphanumeric and '-'")
  @maxLength(128)
  @pattern("^([a-z0-9-._:]{0,127}[a-z0-9-])$")
  registrationId: string;

  @visibility("read", "create", "update")
  @doc("Onboarding status of the resource this DeviceProvisioningState extends")
  onboardingStatus: OnboardingStatus;

  @doc("Indicates if the device is enabled for discovery")
  discoveryEnabled?: boolean = false;

  @doc("The provisioning policy resource id")
  provisioningPolicyResourceId: ProvisioningPolicyResourceId;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ResourceProvisioningState;
}

@doc("The current onboarding status.")
enum OnboardingStatus {
  @doc("Onboarding is still pending")
  Pending,
  @doc("The resource has been onboarded")
  Provisioned,
  @doc("Onboarding has failed")
  Failed
}

@armResourceOperations
interface DeviceProvisioningStates {
  get is ArmResourceRead<DeviceProvisioningState>;
  createOrUpdate is EdgeProvisioningOperations.EdgeProvisioningResourceCreateOrUpdateAsync<DeviceProvisioningState>;
  delete is ArmResourceDeleteSync<DeviceProvisioningState>;
  update is ArmResourcePatchSync<DeviceProvisioningState, DeviceProvisioningStateProperties>;
  listByParent is ArmResourceListByParent<DeviceProvisioningState>;
}