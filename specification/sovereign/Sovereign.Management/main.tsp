import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./landingZoneConfigurationModels.tsp";
import "./landingZoneRegistrationModels.tsp";
import "./transparencyLogModels.tsp";
import "./common.tsp";
import "./landingZoneTemplateModels.tsp";
import "./landingZoneAssociationModels.tsp";

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
@armCommonTypesVersion("v5")
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

// Landing zone template resource type
@added(Versions.Preview20241031)
@doc("The Landing Zone template resource type.")
model LandingZoneTemplate is TrackedResource<LandingZoneTemplateProperties> {
  @doc("The name of the landing zone template resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("name")
  @segment("landingZoneTemplates")
  @path
  name: string;
}

@added(Versions.Preview20241031)
@armResourceOperations(LandingZoneTemplate)
interface LandingZoneTemplates
  extends TrackedResourceOperations<
      LandingZoneTemplate,
      LandingZoneTemplateProperties
    > {
  @action("generateLandingZone")
  @doc("Generate the landing zone.")
  @added(Versions.Preview20241031)
  @armResourceAction(LandingZoneTemplate)
  generateLandingZone is ArmResourceActionAsync<
    LandingZoneTemplate,
    GenerateLandingZoneRequest,
    GenerateLandingZoneResponse
  >;

  @action("updateAuthoringStatus")
  @doc("Provides a mechanism to update the authoring status.")
  @added(Versions.Preview20241031)
  @armResourceAction(LandingZoneTemplate)
  updateAuthoringStatus is ArmResourceActionSync<
    LandingZoneTemplate,
    UpdateAuthoringStatusRequest,
    UpdateAuthoringStatusResponse
  >;

  @action("createCopy")
  @doc("Provides a mechanism to create a copy of the landing zone template.")
  @added(Versions.Preview20241031)
  @armResourceAction(LandingZoneTemplate)
  createCopy is ArmResourceActionSync<
    LandingZoneTemplate,
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

// Landing zone association Resource Type
@added(Versions.Preview20241031)
@doc("The Landing Zone association resource type")
model LandingZoneAssociation
  is TrackedResource<LandingZoneAssociationProperties> {
  @doc("The name of the Landing Zone association resource.")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @key("name")
  @segment("landingZoneAssociations")
  @path
  name: string;
}

@added(Versions.Preview20241031)
@armResourceOperations(LandingZoneAssociation)
interface LandingZoneAssociations
  extends TrackedResourceOperations<
      LandingZoneAssociation,
      LandingZoneAssociationProperties
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

@added(Versions.Preview20240331)
@armResourceOperations
interface TransparencyLogs {
  get is ArmResourceRead<TransparencyLog>;
  create is ArmResourceCreateOrReplaceSync<TransparencyLog>;
  update is ArmResourcePatchSync<TransparencyLog, TransparencyLogProperties>;
  delete is ArmResourceDeleteSync<TransparencyLog>;
  listByTenant is ArmResourceListByParent<TransparencyLog>;
}
