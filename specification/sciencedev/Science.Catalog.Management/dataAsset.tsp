import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./dataContainer.tsp";
// import "./workspace.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

#suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("Data Asset properties")
model DataAssetProperties {
  ...WithDescription;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The path to the data within its parent container.")
  @visibility(Lifecycle.Read)
  path?: string;
}

@doc("Data Asset tracked resource")
@parentResource(DataContainer)
model DataAsset is TrackedResource<DataAssetProperties> {
  ...ResourceNameParameter<DataAsset>;
}

@armResourceOperations
interface DataAssets {
  get is ArmResourceRead<DataAsset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataAsset>;
  update is ArmResourcePatchAsync<DataAsset, DataAssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataAsset>;
  listByResourceGroup is ArmResourceListByParent<DataAsset>;
  listBySubscription is ArmListBySubscription<DataAsset>;
}
