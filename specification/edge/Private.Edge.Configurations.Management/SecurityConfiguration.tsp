import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./Configuration.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Edge;

@armResourceOperations
interface SecurityConfigurations {
  get is ArmResourceRead<SecurityConfiguration>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SecurityConfiguration>;
  update is ArmResourcePatchSync<
    SecurityConfiguration,
    SecurityConfigurationProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<SecurityConfiguration>;
  listByConfiguration is ArmResourceListByParent<SecurityConfiguration>;
}

@doc("SecurityConfiguration Resource")
@parentResource(Configuration)
model SecurityConfiguration is ProxyResource<SecurityConfigurationProperties> {
  ...ResourceNameParameter<
    SecurityConfiguration,
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9-_]{2,22}[a-zA-Z0-9]$"
  >;
}

@doc("SecurityConfiguration Properties")
model SecurityConfigurationProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;

  @doc("References for the secrets from keyvaults")
  @extension("x-ms-identifiers", ["secretName"])
  secretReferences: SecretReference[];
}

@doc("Reference to the secret")
model SecretReference {
  @doc("resourceId to the keyvault")
  keyvaultResourceId: string;

  @doc("name of the secret")
  secretName: string;

  @doc("type of the secret")
  secretType: SecretType;

  @doc("vaultUri of the keyvault")
  @visibility("read")
  vaultUri: url;
}

@doc("Type of secrets supported")
union SecretType {
  @doc("Type Secret")
  Secret: "secret",

  @doc("Type Certificate")
  Certificate: "certificate",

  string,
}
