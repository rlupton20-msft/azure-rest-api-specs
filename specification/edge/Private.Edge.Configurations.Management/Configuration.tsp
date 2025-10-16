import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Versioning;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Private.Edge;

@doc("Configuration Properties")
model ConfigurationProperties {
  @doc("Provisioning state of resource")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  @doc("Managed Infrastructure Configurations.")
  @removed(Versions.v2025_08_01)
  managedInfraConfigurations?: ManagedInfraConfigurations;

  @doc("Managed On Behalf Of Configuration.")
  @visibility(Lifecycle.Read)
  @removed(Versions.v2025_08_01)
  managedOnBehalfOfConfiguration?: CommonTypes.ManagedOnBehalfOfConfiguration;
}

@doc("Managed Infrastructure Configurations.")
model ManagedInfraConfigurations {
  @doc("enabled")
  enabled?: boolean = false;

  @doc("Name of the resource group to be used for managed resources. If not provided, a new resource group will be created with name format 'ManagedResources-<configurationName>-<randomString>'.")
  managedResourceGroupNameOverride?: string;

  @doc("List of managed resource group resource IDs provisioned. This will be empty if 'enabled' is false. There will be single entry in the list if 'enabled' is true for forseable future. Kept array for extensibility in future.")
  @visibility(Lifecycle.Read)
  managedResourceGroupIds?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Resources/resourceGroups";
    }
  ]>[];
}

@doc("Configuration Resource")
model Configuration is TrackedResource<ConfigurationProperties> {
  @doc("Name of the Configuration")
  @pattern("^(?!.*\\.\\.)[a-zA-Z0-9-][a-zA-Z0-9._-]{1,68}[a-zA-Z0-9-]$")
  @path
  @key("configurationName")
  @segment("configurations")
  name: string;
}

@armResourceOperations
interface Configurations {
  @doc("Get a Configuration Resource")
  get is ArmResourceRead<Configuration>;

  @doc("Create or update a Configuration Resource")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Configuration>;

  @doc("Update a Configuration Resource")
  update is ArmResourcePatchSync<Configuration, ConfigurationProperties>;

  @doc("Delete a Configuration Resource")
  delete is ArmResourceDeleteSync<Configuration>;

  @doc("List by specified resource group")
  listByResourceGroup is ArmResourceListByParent<Configuration>;

  @doc("List by subscription")
  listBySubscription is ArmListBySubscription<Configuration>;
}

@doc("ConfigurationReference Resource")
model ConfigurationReference
  is ExtensionResource<ConfigurationReferenceProperties> {
  ...ResourceNameParameter<ConfigurationReference, NamePattern = "^default$">;
}

@doc("Properties for ConfigurationReference Resource")
model ConfigurationReferenceProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
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
  list is ArmResourceListByParent<ConfigurationReference>;
}
