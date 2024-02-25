import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace GitHub.Network;
/**
 * GitHub.Network networkSettings resource. Represents the network settings needed for vnet injection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkSettingsResourceProperties
)
model NetworkSettingsResource extends TrackedResourceBase {
  /**
   * Name of the GitHub.Network resource
   */
  @pattern("^[a-zA-Z0-9]")
  @path
  @key("networkSettingsName")
  @segment("networkSettings")
  @visibility("read")
  name: string;

  /**
   * NetworkSettings resource-specific properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkSettingsResourceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetworkSettingsResources {
  /**
   * Retrieves the properties of a GitHub.Network networkSettings resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("networkSettings_Get")
  get is ArmResourceRead<NetworkSettingsResource>;

  /**
   * Creates a GitHub.Network networkSettings resource with the specified create parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("networkSettings_Create")
  create is ArmResourceCreateOrReplaceSync<NetworkSettingsResource>;

  /**
   * Updates the properties of an existing GitHub.Network networkSettings resource with the specified update parameters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("networkSettings_Update")
  update is ArmCustomPatchSync<NetworkSettingsResource>;

  /**
   * Deletes an existing GitHub.Network networkSettings resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("networkSettings_Delete")
  delete is ArmResourceDeleteSync<NetworkSettingsResource>;

  /**
   * Retrieves the properties of all GitHub.Network networkSettings resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("networkSettings_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkSettingsResource>;

  /**
   * Retrieves the properties of all GitHub.Network networkSettings resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("networkSettings_ListBySubscription")
  listBySubscription is ArmListBySubscription<NetworkSettingsResource>;
}

@@projectedName(NetworkSettingsResources.create::parameters.resource,
  "json",
  "networkSettings"
);
@@extension(NetworkSettingsResources.create::parameters.resource,
  "x-ms-client-name",
  "networkSettings"
);
@@doc(NetworkSettingsResources.create::parameters.resource,
  "GitHub.Network networkSettings resource create parameters."
);
@@projectedName(NetworkSettingsResources.update::parameters.properties,
  "json",
  "networkSettings"
);
@@extension(NetworkSettingsResources.update::parameters.properties,
  "x-ms-client-name",
  "networkSettings"
);
@@doc(NetworkSettingsResources.update::parameters.properties,
  "Parameters for updating the GitHub.Network resource."
);
