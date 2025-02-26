import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop storage account connector resource.")
@resource("storageaccountconnectors")
model StorageAccountConnector
  is TrackedResource<StorageAccountConnectorProperties> {
  @doc("The name of the storage account connector resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("storageAccountConnectorName")
  @segment("storageaccountconnectors")
  @path
  name: string;
}

@doc("StorageAccountConnector properties")
model StorageAccountConnectorProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningLROState;

  @doc("Resource ID of the hub resource to associate the storage account connector to.")
  hubResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hubs";
    }
  ]>;

  @doc("URL of the Azure storage account container to connect to.")
  @pattern(".+\\.blob\\.core\\.windows\\.net\\/.+")
  storageAccountContainerUrl: string;

  @doc("The blob prefix to use when reading/writing blobs from/to an Azure Storage container. If not specified, root of the container will be used.")
  blobPrefix?: string;
}

@armResourceOperations
interface StorageAccountConnectors {
  get is ArmResourceRead<StorageAccountConnector>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageAccountConnector>;
  update is ArmResourcePatchAsync<
    StorageAccountConnector,
    StorageAccountConnectorProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<StorageAccountConnector>;
  listByResourceGroup is ArmResourceListByParent<StorageAccountConnector>;
  listBySubscription is ArmListBySubscription<StorageAccountConnector>;
}
