import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("GenevaActionsExtension properties")
model GenevaActionsExtensionResourceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("User given name for GenevaActionExtension.")
  name: string; // camel case for the parameter names

  @doc("User provided package source branch.")
  packageSourceBranch: string;

  @doc("This is the sub folder path to the package folder relative to the branch root.")
  packageSourceRelativePath: string;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: GenevaActionsExtensionProvisioningState;
}

@doc("GenevaActionsExtension Resource")
model GenevaActionsExtensionResource
  is ProxyResource<GenevaActionsExtensionResourceProperties> { // This can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("resourceName")
  @segment("genevaActionsExtensions") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface GenevaActionsExtension {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<GenevaActionsExtensionResource>;
  get is ArmResourceRead<GenevaActionsExtensionResource>;
  listByResourceGroup is ArmResourceListByParent<GenevaActionsExtensionResource>;
  listBySubscription is ArmListBySubscription<GenevaActionsExtensionResource>;
}
