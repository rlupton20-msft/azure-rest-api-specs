import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.ApplicationMigration;

/** Connection Hub resource */
model ConnectionHub is TrackedResource<ConnectionHubProperties> {
  ...ResourceNameParameter<ConnectionHub>;
}

/** Connection Hub properties */
model ConnectionHubProperties {
  /** The status of the last operation */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Connection Hub description */
  description?: string;

  /** Connection Hub status */
  @visibility(Lifecycle.Read)
  status?: ConnectionStatus;
}

@armResourceOperations
interface ConnectionHubs {
  /** Get a Connection Hub */
  get is ArmResourceRead<ConnectionHub>;

  /** Create or update a Connection Hub */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ConnectionHub>;

  /** Update a Connection Hub */
  update is ArmResourcePatchSync<ConnectionHub, ConnectionHubProperties>;

  /** Delete a Connection Hub */
  delete is ArmResourceDeleteWithoutOkAsync<ConnectionHub>;

  /** List Connection Hubs by resource group */
  listByResourceGroup is ArmResourceListByParent<ConnectionHub>;

  /** List Connection Hubs by subscription */
  listBySubscription is ArmListBySubscription<ConnectionHub>;
}
