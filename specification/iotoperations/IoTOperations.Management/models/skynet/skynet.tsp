import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Private.IoTOperations;

/** ******************* */
/**
 * skynet resource type model details.
 */
@doc("Instance skynet resource")
@parentResource(InstanceResource)
model SkynetResource is ProxyResource<SkynetProperties> {
  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Skynet Resource properties")
model SkynetProperties {
  @doc("Spec defines the desired identities of skynet settings.")
  accessLevel?: AccessLevel;

  @doc("To manually scale the dataflow profile, specify the maximum number of instances you want to run.")
  expirationTimeStamp?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Skynet AccessLevel Type properties")
union AccessLevel {
  string,

  @doc("Diagnose access level")
  Diagnose: "Diagnose",
}
