import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.IoTOperations;

@doc("A Instance resource is a logical container for a set of child resources.")
model InstanceResource is TrackedResource<InstanceProperties> {
  @doc("Name of instance.")
  @key("instanceName")
  @segment("instances")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;

  ...ManagedServiceIdentityProperty;
}

@doc("The Instance update model.")
model InstancePatchModel {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
}

@doc("Represents the activation state of Skynet.")
union SkynetActivationState {
  string,

  @doc("Skynet is enabled.")
  Enabled: "Enabled",

  @doc("Skynet is disabled.")
  Disabled: "Disabled",
}

@doc("The properties for the Skynet Resource. ")
model RemoteSupportProperties {
  @doc("Enabled or disabled.")
  enabled?: SkynetActivationState;

  @doc("Access level for Skynet.")
  accessLevel?: SkynetAccessLevels;

  @doc("Expiration timestamp for Skynet.")
  expirationTimeStamp?: string;
}

@doc("SkynetAccessLevels allowed")
union SkynetAccessLevels {
  string,

  @doc("Diagnose access level")
  Diagnose: "Diagnose",

  @doc("Diagnose And Repair Access Level")
  DiagnoseAndRepair: "DiagnoseAndRepair",
}

@doc("Wraps the Skynet properties under 'remoteSupport'.")
model RemoteSupportItem {
  /**
   * Represents the remote support configuration for the instance.
   *
   * This property holds Skynet-specific settings required for enabling
   * remote support.
   */
  remoteSupport: RemoteSupportProperties;
}

@doc("The properties of the Instance resource.")
model InstanceProperties {
  @doc("Detailed description of the Instance.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The Azure IoT Operations version.")
  @visibility("read")
  version?: string;

  @doc("The reference to the Schema Registry for this AIO Instance.")
  schemaRegistryRef: SchemaRegistryRef;

  @doc("The Skynet Resource for this AIO Instance.")
  @OpenAPI.extension("x-ms-identifiers", [])
  skynets?: RemoteSupportItem[];
}

@doc("The reference to the Schema Registry for this AIO Instance.")
model SchemaRegistryRef {
  @doc("The resource ID of the Schema Registry.")
  resourceId: SchemaRegistryID;
}
