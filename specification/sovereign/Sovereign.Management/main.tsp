import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./landingZoneConfigurationModels.tsp";
import "./landingZoneRegistrationModels.tsp";
import "./transparencyLogModels.tsp";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using OpenAPI;
using Autorest;
using Azure.ResourceManager.Foundations;

@service({
  title: "Cloud for Sovereignty Resource Provider.",
})
@versioned(Versions)
@armProviderNamespace
namespace Microsoft.Sovereign;

interface Operations extends Azure.ResourceManager.Operations {}

// Landing zone configuration Resource Type
@tenantResource
@added(Versions.Preview20230928)
@doc("The Landing Zone configuration resource type.")
model LandingZoneConfiguration
  is ProxyResource<LandingZoneConfigurationProperties> {
  @doc("The name of the landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("name")
  @segment("landingZoneConfigurations")
  @path
  name: string;
}

@armResourceOperations(LandingZoneConfiguration)
interface LandingZonesConfigurations
  extends TenantResourceOperations<
      LandingZoneConfiguration,
      LandingZoneConfigurationProperties
    > {
  @action("generateLandingZone")
  @doc("Generate the landing zone.")
  @added(Versions.Preview20230928)
  @armResourceAction(LandingZoneConfiguration)
  generateLandingZone is ArmResourceActionAsync<
    LandingZoneConfiguration,
    GenerateLandingZoneRequest,
    GenerateLandingZoneResponse
  >;

  @action("updateAuthoringStatus")
  @doc("Provides a mechanism to update the authoring status.")
  @added(Versions.Preview20230928)
  @armResourceAction(LandingZoneConfiguration)
  updateAuthoringStatus is ArmResourceActionSync<
    LandingZoneConfiguration,
    UpdateAuthoringStatusRequest,
    UpdateAuthoringStatusResponse
  >;

  @action("createCopy")
  @doc("Provides a mechanism to create a copy of the landing zone configuration.")
  @added(Versions.Preview20230928)
  @armResourceAction(LandingZoneConfiguration)
  createCopy is ArmResourceActionSync<
    LandingZoneConfiguration,
    CreateCopyRequest,
    CreateCopyResponse
  >;
}

// Landing zone configuration Resource Type V2
@added(Versions.Preview20240831)
@doc("The Landing Zone configuration resource type V2.")
model LandingZoneConfigurationV2
  is TrackedResource<LandingZoneConfigurationPropertiesV2> {
  @doc("The name of the landing zone configuration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("name")
  @segment("landingZoneConfigurations")
  @path
  name: string;
}

@added(Versions.Preview20240831)
@armResourceOperations(LandingZoneConfigurationV2)
interface LandingZonesConfigurationsV2
  extends TrackedResourceOperations<
      LandingZoneConfigurationV2,
      LandingZoneConfigurationPropertiesV2
    > {
  @action("generateLandingZone")
  @doc("Generate the landing zone.")
  @added(Versions.Preview20240831)
  @armResourceAction(LandingZoneConfigurationV2)
  generateLandingZone is ArmResourceActionAsync<
    LandingZoneConfigurationV2,
    GenerateLandingZoneRequest,
    GenerateLandingZoneResponse
  >;

  @action("updateAuthoringStatus")
  @doc("Provides a mechanism to update the authoring status.")
  @added(Versions.Preview20240831)
  @armResourceAction(LandingZoneConfigurationV2)
  updateAuthoringStatus is ArmResourceActionSync<
    LandingZoneConfigurationV2,
    UpdateAuthoringStatusRequest,
    UpdateAuthoringStatusResponse
  >;

  @action("createCopy")
  @doc("Provides a mechanism to create a copy of the landing zone configuration.")
  @added(Versions.Preview20240831)
  @armResourceAction(LandingZoneConfigurationV2)
  createCopy is ArmResourceActionSync<
    LandingZoneConfigurationV2,
    CreateCopyRequest,
    CreateCopyResponse
  >;
}

// Landing zone registration Resource Type
@tenantResource
@added(Versions.Preview20230928)
@doc("The Landing Zone registration resource type.")
model LandingZoneRegistration
  is ProxyResource<LandingZoneRegistrationProperties> {
  @doc("The name of the Landing Zone registration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("name")
  @segment("landingZoneRegistrations")
  @path
  name: string;
}

@armResourceOperations(LandingZoneRegistration)
interface LandingZoneRegistrations
  extends TenantResourceOperations<
      LandingZoneRegistration,
      LandingZoneRegistrationProperties
    > {}

// Landing zone registration Resource Type V2
@added(Versions.Preview20240831)
@doc("The Landing Zone registration resource type V2.")
model LandingZoneRegistrationV2
  is TrackedResource<LandingZoneRegistrationProperties> {
  @doc("The name of the Landing Zone registration resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("name")
  @segment("landingZoneRegistrations")
  @path
  name: string;
}

@added(Versions.Preview20240831)
@armResourceOperations(LandingZoneRegistrationV2)
interface LandingZoneRegistrationsV2
  extends TrackedResourceOperations<
      LandingZoneRegistrationV2,
      LandingZoneRegistrationProperties
    > {}

// Transparency Logs setting Resource Type
@tenantResource
@added(Versions.Preview20240331)
@doc("The Transparency Log resource type.")
model TransparencyLog is ProxyResource<TransparencyLogProperties> {
  @doc("The name of the Transparency Log resource.")
  @pattern("^[a-zA-Z0-9-]{1,64}$")
  @key("name")
  @segment("transparencyLogs")
  @path
  name: string;
}

@armResourceOperations(TransparencyLog)
@added(Versions.Preview20240331)
interface TransparencyLogs
  extends TenantResourceOperations<
      TransparencyLog,
      TransparencyLogProperties
    > {}
