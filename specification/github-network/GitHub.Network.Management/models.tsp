import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace GitHub.Network;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning status of the managed application.
 */
enum ProvisioningState {
  Failed,
  Succeeded,
  Canceled,
  Accepted,
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity. The value must be an UUID.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource. The value must be an UUID.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * NetworkSettings resource-specific properties.
 */
model NetworkSettingsResourceProperties {
  /**
   * Specifies a subnet ID for vnet-injection.
   */
  subnetId?: string;

  /**
   * Specifies the GitHub organization (enterprise) ID associated to the Azure subscription.
   */
  organizationId?: string;

  /**
   * The managed application provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * GitHub.Network networkSettings patch resource. Represents a patch version of the networkSettings resource.
 */
model NetworkSettingsResourcePatch extends Resource {
  /**
   * The managed identity associated with the resource.
   */
  identity?: Identity;

  /**
   * NetworkSettings resource-specific properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkSettingsResourceProperties;
}
