import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Supercomputer tracked resource")
model Supercomputer is TrackedResource<SupercomputerProperties> {
  ...ResourceNameParameter<Supercomputer>;
}

@doc("Supercomputer properties")
model SupercomputerProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  // read
  @doc("The mobo settings.")
  @visibility("read")
  managedResourceGroup: string; // TODO: MObo config

  // read
  @doc("The ID of the workspace.")
  @visibility("read")
  workspaceId: string; // ARM ID
}

@armResourceOperations
interface Supercomputers {
  get is ArmResourceRead<Supercomputer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Supercomputer>;
  update is ArmResourcePatchSync<Supercomputer, SupercomputerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Supercomputer>;
  listByResourceGroup is ArmResourceListByParent<Supercomputer>;
  listBySubscription is ArmListBySubscription<Supercomputer>;
}
