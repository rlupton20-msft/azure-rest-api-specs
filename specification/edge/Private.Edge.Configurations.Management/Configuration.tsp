import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Configuration Resource")
model Configuration is TrackedResource<ConfigurationProperties> {
  ...ResourceNameParameter<Configuration>;
}

@doc("Configuration Properties")
model ConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@armResourceOperations
interface Configurations {
  @doc("Get a Configuration Resource")
  get is ArmResourceRead<Configuration>;

  @doc("Create or update a Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Configuration>;

  @doc("Update a Configuration Resource")
  update is ArmResourcePatchSync<Configuration, ConfigurationProperties>;

  @doc("Delete a Configuration Resource")
  delete is ArmResourceDeleteWithoutOkAsync<Configuration>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Configuration>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Configuration>;
}

@doc("ConfigurationReference Resource")
@singleton("default")
model ConfigurationReference
  is ExtensionResource<ConfigurationReferenceProperties> {
  ...ResourceNameParameter<ConfigurationReference, NamePattern = "^default$">;
}

@doc("Properties for ConfigurationReference Resource")
model ConfigurationReferenceProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("ArmId of Configuration resource")
  configurationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Edge/Configurations";
    },
    {
      type: "Private.Edge/Configurations";
    }
  ]>;
}

@armResourceOperations
interface ConfigurationReferences {
  get is ArmResourceRead<ConfigurationReference>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ConfigurationReference>;
  update is ArmResourcePatchSync<
    ConfigurationReference,
    ConfigurationReferenceProperties
  >;
  delete is ArmResourceDeleteSync<ConfigurationReference>;

  // Removing list operation since ConfigurationReference is a singleton
  // list is ArmResourceListByParent<ConfigurationReference>;
}
