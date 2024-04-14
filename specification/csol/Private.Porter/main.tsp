import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

// @armProviderNamespace("Private.Porter")
@armProviderNamespace
@service({
  title: "Microsoft.CompositeSolutions",
})

@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
// @versioned(Microsoft.CompositeSolutions.Versions)
@versioned(Versions)
namespace Private.Porter;

@doc("Supported API versions for the Microsoft.CompositeSolutions resource provider.")
enum Versions {
  @doc("The 2024-03-01-preview version.")
  @Versioning.useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  v2024_03_01_preview: "2024-03-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A CompositeSolutionProviderHub resource")
model CompositeSolutionDefinition is TrackedResource<CompositeSolutionDefinitionProperties> {
  @doc("The name of the composite solution definition")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("compositeSolutionDefinition")
  @segment("compositeSolutionDefinitions")
  @path
  name: string;

  ...ManagedServiceIdentity;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A CompositeSolutionProviderHub resource")
model CompositeSolution is TrackedResource<CompositeSolutionProperties> {
  @doc("The name of the composite solution")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("compositeSolutionName")
  @segment("compositeSolutions")
  @path
  name: string;

  ...ManagedServiceIdentity;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
  ...ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning,

  @doc("Update in progress")
  Updating,

  @doc("Deletion in progress")
  Deleting,

  @doc("Change accepted for processing")
  Accepted,
}

@doc("Details of the CompositeSolutionDefinition.")
model CompositeSolutionDefinitionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("Bundle Profile.")
  bundleProfile: BundleProfile;
 
  @visibility("read")
  @doc("Parameters for the composite solution")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters?: Array<Parameter>;

  @visibility("read")
  @doc("Credentials for the composite solution")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  credentials?: Array<Credential>;

  @visibility("read")
  @doc("List of mixins used in the composite solution package")
  mixins?: Array<string>;

  @visibility("read")
  @doc("List of metadata objects")
  @OpenAPI.extension("x-ms-identifiers", [])
  metadata?: Array<CrpMetadata>;

}

@doc("Metadata associated with the bundle")
model CrpMetadata {

  @doc("Schema version of the metadata")
  schema: string;

  @doc("Name of the metadata")
  mixin: string;

}

@doc("Details of the CompositeSolution.")
model CompositeSolutionProperties {
  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read", "create", "update")
  @doc("compositeSolutionDefinition resource identifier indicating which solution to deploy")
  compositeSolutionDefinitionId: string;

  @visibility("read", "create", "update")
  @doc("Bundle Parameters.")
  @OpenAPI.extension("x-ms-identifiers", ["name"])
  parameters: Array<ParameterValue>;

  // This isn't actually a secret, but a reference to a secret in AKV, so is it safe to return back in the read request?
  @visibility("read", "create", "update")
  @doc("Array of secret")
  @OpenAPI.extension("x-ms-identifiers", ["credentialName"])
  credentials?: Array<KeyVaultSecretReference>;

  // TODO: Do we need this?
  @visibility("read")
  @doc("Bundle Outputs.")
  outputs?: Array<string>;

  @visibility("read", "create", "update")
  @doc("Bundle Friendly Name.")
  friendlyName?: string;

  @visibility("read","create", "update")
  @doc("Solution Center Offer ID.")
  saasOfferId?: string;
}

@doc("KeyVault Secret Reference")
model KeyVaultSecretReference {

 @doc("The secret name")
  credentialName: string;

  @doc("The secret name")
  secretName: string;
}

@doc("Paramter Value")
model ParameterValue {

  @doc("The parameter name")
  name: string;

  //Object types cannot be built correctly. The value will be added in .NET code directly.
 
}

@doc("Parameter")
model Parameter {
 
  @doc("Parameter name")
  name: string;

  @doc("Data type of the parameter (string, int, etc)")
  type?: string;

  @doc("Minimum value allowed (> than value specified).  Only applies to numerics.")
  exclusiveMinimum?: integer;

  @doc("Maximum value allowed (< than value specified). Only applies to numerics.")
  exclusiveMaximum?: integer;

  @doc("Whether the parameter is required or not")
  isRequired: boolean;

  @doc("Maximum value allowed (>= value specified). Only applies to numerics.")
  maximum?: integer;

  @doc("Minimum value allowed (<= value specified). Only applies to numerics.")
  minimum?: integer;

  @doc("Description of the parameter")
  description?: string;

  @doc("The maximum length of the parameter. Only applies to strings.")
  maxLength?: integer;

  @doc("The minimum length of the parameter. Only applies to strings.")
  minLength?: integer;

  @doc("Which operations this parameter applies to. If not specified, this parameter applies to all operations.")
  applicableOperations: Array<string>;

  @doc("Which Microsoft cloud(s) the parameter applies to")
  microsoftTargets: Array<string>;

}

@doc("Credential")
model Credential {
  @doc("Name")
  name: string;
  @doc("Is Required")
  isRequired: boolean;
  @doc("Applicable Operations")
  applicableOperations: Array<string>;
}

@doc("The properties related to Bundle")
model BundleProfile {
  
  @doc("Repository is the OCI repository of the current bundle")
  @visibility("read", "create")
  repository: string;

  @doc("Version is the current version of the bundle.")
  @visibility("read", "create", "update")
  version: string;

  @doc("Digest is the current digest of the bundle.")
  @visibility("read", "create", "update")
  digest?: string;

  @doc("Tag is the OCI tag of the current bundle definition.")
  @visibility("read", "create", "update")
  tag?: string;

}

@armResourceOperations(CompositeSolution)
interface CompositeSolutions  {
  get is ArmResourceRead<CompositeSolution>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<CompositeSolution>;
  update is ArmResourcePatchAsync<CompositeSolution, CompositeSolutionProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<CompositeSolution>;
  listByResourceGroup is ArmResourceListByParent<CompositeSolution>;
  listBySubscription is ArmListBySubscription<CompositeSolution>;
}

@armResourceOperations(CompositeSolutionDefinition)
interface CompositeSolutionDefinitions  {
  get is ArmResourceRead<CompositeSolutionDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<CompositeSolutionDefinition>;
  update is ArmResourcePatchSync<CompositeSolutionDefinition, CompositeSolutionDefinitionProperties>;
  delete is ArmResourceDeleteSync<CompositeSolutionDefinition>;
  listByResourceGroup is ArmResourceListByParent<CompositeSolutionDefinition>;
  listBySubscription is ArmListBySubscription<CompositeSolutionDefinition>;
}
