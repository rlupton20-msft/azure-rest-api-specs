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
  @doc("Name of Instance skynet resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("skynetName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("skynets")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Skynet Resource properties")
model SkynetProperties {
  @doc("Access level for Skynet.")
  accessLevel?: SkynetPropertiesAccessLevels;

  @doc("Expiration timestamp for Skynet.")
  expirationTimeStamp?: string;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("SkynetPropertiesAccessLevels allowed")
union SkynetPropertiesAccessLevels {
  string,

  @doc("Diagnose access level")
  Diagnose: "Diagnose",
}
