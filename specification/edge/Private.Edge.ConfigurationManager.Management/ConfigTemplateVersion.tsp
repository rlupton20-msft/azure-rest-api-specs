import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./ProvisioningState.tsp";
import "./UpdateType.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.Edge;

@doc("Config Template Version Properties")
model ConfigTemplateVersionProperties {
  @doc("Schema of configuration")
  schema: string;

  @doc("Configuration values")
  configurations: string;

  @doc("Provisioning state of resource")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Config Template Version Resource")
@parentResource(ConfigTemplate)
@resource("versions")
model ConfigTemplateVersion
  is Azure.ResourceManager.ProxyResource<ConfigTemplateVersionProperties> {
  ...ResourceNameParameter<
    ConfigTemplateVersion,
    NamePattern = "^[0-9]+\\.[0-9]+\\.[0-9]+$"
  >;
  ...EntityTagProperty;
}

@armResourceOperations
interface ConfigTemplateVersions {
  @doc("Get a Config Template Version Resource")
  get is ArmResourceRead<ConfigTemplateVersion>;

  @doc("Create or update a Config Template Version Resource with the specified UpdateType")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ConfigTemplateVersion,
    {
      ...BaseParameters<ConfigTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("update a Config Template Version Resource")
  update is ArmResourcePatchSync<
    ConfigTemplateVersion,
    ConfigTemplateProperties,
    {
      ...BaseParameters<ConfigTemplateVersion>;
      ...VersionUpdateQueryParameters;
    }
  >;

  @doc("Delete a Config Template Version Resource")
  delete is ArmResourceDeleteWithoutOkAsync<ConfigTemplateVersion>;

  @doc("List Config Template Version Resources")
  listByConfigTemplate is ArmResourceListByParent<ConfigTemplateVersion>;
}
