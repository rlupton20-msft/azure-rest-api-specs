import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop hub resource.")
model Hub is Azure.ResourceManager.TrackedResource<HubProperties> {
  @doc("The name of the hub resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("hubName")
  @segment("hubs")
  @path
  name: string;
}

@doc("Hub properties")
model HubProperties {
  @doc("Name to be used for the managed resource group that will be created.")
  @visibility("create", "read")
  managedResourceGroupName: string;

  @doc("Environments hosted on remote locations where Connectors can be deployed.")
  remoteConnectorEnvironments?: Array<RemoteConnectorEnvironment>;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningLROState;
}

@doc("An Environment hosted on a remote location where Connectors can be deployed.")
model RemoteConnectorEnvironment {
  @doc("The name of the remote connector environment connected cluster.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility("create", "read")
  name: string;

  @doc("The resource id of the remote connector environment connected cluster.")
  @visibility("create", "read")
  connectedClusterId: armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;

  @doc("The geo-location where the connected cluster is provisioned.")
  @visibility("create", "read", "update")
  location: string;

  @doc("The resource id of the healthcare extension.")
  @visibility("create", "read", "update")
  healthcareExtentionId: armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters/Microsoft.KubernetesConfiguration/extensions";
    }
  ]>;

  @doc("The custom location associated with the healthcare extension.")
  @visibility("create", "read", "update")
  customLocation: CustomLocation;

  @doc("The managed identity used by the storage extension.")
  @visibility("create", "read", "update")
  storageExtensionManagedIdentity: ExtensionManagedIdentity;
}

@doc("The custom location.")
model CustomLocation {
  @doc("The name of the custom location resource.")
  @visibility("create", "read", "update")
  name: string;

  @doc("The resource if of the custom location resource.")
  @visibility("create", "read", "update")
  id: armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("The managed identity used for extensions.")
model ExtensionManagedIdentity {
  @doc("The principal id of the managed identity.")
  @visibility("create", "read", "update")
  principalId: string;

  @doc("The managed identity type.")
  @visibility("create", "read", "update")
  type: ManagedServiceIdentityType;
}

@armResourceOperations
interface Hubs {
  get is ArmResourceRead<Hub>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Hub>;
  update is ArmResourcePatchAsync<Hub, HubProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Hub>;
  listByResourceGroup is ArmResourceListByParent<Hub>;
  listBySubscription is ArmListBySubscription<Hub>;
}
