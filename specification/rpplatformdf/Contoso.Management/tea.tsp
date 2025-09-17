import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";
import "./provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Contoso;

/** Tea resource */
model Tea is TrackedResource<TeaProperties> {
  ...ResourceNameParameter<Tea>;
}

/** Tea properties */
model TeaProperties {
  /** Type of Tea */
  @pattern("^[A-Za-z0-9-._]+$")
  @minLength(1)
  @maxLength(20)
  teaType: string;

  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Teas {
  get is ArmResourceRead<Tea>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Tea>;
  update is ArmResourcePatchSync<Tea, TeaProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Tea>;
  listByResourceGroup is ArmResourceListByParent<Tea>;
  listBySubscription is ArmListBySubscription<Tea>;
}
