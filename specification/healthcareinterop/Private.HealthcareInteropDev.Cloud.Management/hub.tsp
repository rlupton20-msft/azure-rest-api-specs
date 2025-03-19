import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/resourceIds.tsp";
import "./common/scalarExtensions.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

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
  @doc("The managed infra configuration.")
  managedInfraConfiguration: ManagedInfraConfiguration;

  @doc("The managed on behalf of configuration.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("Environments hosted on remote locations where Connectors can be deployed.")
  remoteConnectorEnvironments?: Array<RemoteConnectorEnvironment>;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;
}

@doc("The managed on behalf of infra configuration.")
model ManagedInfraConfiguration {
  @doc("Name to be used for the managed resource group that will be created.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  resourceGroupName: string;

  @doc("The managed on behalf of storage account configuration.")
  @visibility(Lifecycle.Read)
  storageAccount?: StorageAccountConfiguration;

  @doc("The managed on behalf of key vault configuration.")
  @visibility(Lifecycle.Read)
  keyVault?: KeyVaultConfiguration;
}

@doc("Storage account configuration.")
model StorageAccountConfiguration {
  @doc("The resource ID of the storage account.")
  @visibility(Lifecycle.Read)
  storageAccountResourceId: StorageAccountResourceId;

  @doc("The storage account blob service endpoint.")
  @visibility(Lifecycle.Read)
  storageAccountBlobEndpoint: BlobServiceEndpoint;
}

@doc("Key Vault configuration.")
model KeyVaultConfiguration {
  @doc("The resource ID of the key vault.")
  @visibility(Lifecycle.Read)
  keyVaultResourceId: KeyVaultResourceId;

  @doc("The URI of the key vault.")
  @visibility(Lifecycle.Read)
  keyVaultUri: KeyVaultURI;
}

@doc("An Environment hosted on a remote location where Connectors can be deployed.")
model RemoteConnectorEnvironment {
  @doc("The name of the remote connector environment connected cluster.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  @doc("The resource id of the remote connector environment connected cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  connectedClusterId: armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters";
    }
  ]>;

  @doc("The geo-location where the connected cluster is provisioned.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  location: string;

  @doc("The resource id of the healthcare extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  healthcareExtentionId: armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters/Microsoft.KubernetesConfiguration/extensions";
    }
  ]>;

  @doc("The custom location associated with the healthcare extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  customLocation: CustomLocation;

  @doc("The managed identity used by the storage extension.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  storageExtensionManagedIdentity: ExtensionManagedIdentity;
}

@doc("The custom location.")
model CustomLocation {
  @doc("The name of the custom location resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  name: string;

  @doc("The resource if of the custom location resource.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  id: armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations";
    }
  ]>;
}

@doc("The managed identity used for extensions.")
model ExtensionManagedIdentity {
  @doc("The principal id of the managed identity.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  principalId: string;

  @doc("The managed identity type.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  type: Azure.ResourceManager.Foundations.ManagedServiceIdentityType;
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
