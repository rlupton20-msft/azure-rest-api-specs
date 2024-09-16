import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("GenevaActionsExtension properties")
model GenevaActionsExtensionResourceProperties {
  @doc("User-provided name for Geneva Actions Extension.")
  extensionName: string; // camel case for the parameter names

  @doc("User-provided package source branch.")
  packageSourceBranch: string;

  @doc("Sub folder path to the package folder relative to the branch root.")
  packageSourceRelativePath: string;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility("read")
  provisioningState?: GenevaActionsExtensionProvisioningState;
}

@doc("GenevaActionsExtension Resource")
model GenevaActionsExtensionResource
  is ProxyResource<GenevaActionsExtensionResourceProperties> { // This can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
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
