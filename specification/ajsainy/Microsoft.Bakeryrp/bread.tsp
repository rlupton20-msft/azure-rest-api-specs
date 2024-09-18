import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Bakeryrp;

/** Bread resource */
model Bread is TrackedResource<BreadProperties> {
  ...ResourceNameParameter<Bread>;
}

/** Bread properties */
model BreadProperties {
  /** Age of bread */
  age?: int32;

  /** City of bread */
  city?: string;

  /** Profile of bread */
  @encode("base64url")
  profile?: bytes;

  /** The status of the last operation. */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Breads {
  get is ArmResourceRead<Bread>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Bread>;
  update is ArmResourcePatchSync<Bread, BreadProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Bread>;
  listByResourceGroup is ArmResourceListByParent<Bread>;
  listBySubscription is ArmListBySubscription<Bread>;
}
