import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

// import "./workspace.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Data Asset tracked resource")
model DataContainer is TrackedResource<DataContainerProperties> {
  ...ResourceNameParameter<DataContainer>;
}

@doc("The type of the backing data store.")
union DataStoreType {
  @doc("The Azure storage blob type.")
  AzureStorageBlob: "AzureStorageBlob",

  @doc("The Azure storage file type.")
  AzureStorageFile: "AzureStorageFile",

  string,
}

//@discriminator("type")
//@doc("An abstract representation of data store type.")
//model DataStore {
//  @doc("The data store type.")
//  type: DataStoreType;
//}

// @doc("The Azure storage account ID.")
// scalar StorageAccountId
//   extends Azure.Core.armResourceIdentifier<[
//     {
//       type: "Microsoft.Storage/storageAccounts",
//     }
//   ]>;

////@discriminator("type")
//@doc("The Azure storage blob properties.")
//model AzureStorageBlob extends DataStore {
//  @visibility(Lifecycle.Read)
//  type: DataStoreType.AzureStorageBlob;
//
//  @doc("The associated azure storage account ID.")
//  @visibility(Lifecycle.Read, Lifecycle.Create)
//  storageAccountId: StorageAccountId;
//}
//
////@discriminator("type")
//@doc("The Azure storage file properties.")
//model AzureStorageFile extends DataStore {
//  @visibility(Lifecycle.Read)
//  type: DataStoreType.AzureStorageFile;
//
//  @doc("The associated Azure storage file account name.")
//  @visibility(Lifecycle.Read, Lifecycle.Create)
//  storageAccountName: string;
//}

@doc("Data Asset properties")
model DatabaseSettings {
  /** DB port number */
  @visibility(Lifecycle.Read)
  port: int32;

  /** Database name */
  @visibility(Lifecycle.Read)
  database: string;

  /** Database user */
  @visibility(Lifecycle.Read)
  user: string;
}

@doc("The type of the credential used for RBAC against the data store.")
union CredentialType {
  @doc("Managed identity credential type.")
  ManagedIdentity: "ManagedIdentity",

  @doc("Secret stored in Keyvault secret type.")
  KeyvaultSecret: "KeyvaultSecret",

  string,
}

@discriminator("type")
@doc("An abstract representation of data store type.")
model Credential {
  @doc("The data store type.")
  type: CredentialType;
}

@doc("The managed identity credential properties.")
model ManagedIdentityCredential extends Credential {
  @visibility(Lifecycle.Read)
  type: CredentialType.ManagedIdentity;

  @doc("The managed identity client Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  clientId?: string;
}

@doc("SAS token credential properties")
model KeyVaultSecretCredential extends Credential {
  @visibility(Lifecycle.Read)
  type: CredentialType.KeyvaultSecret;

  @doc("The shared access token.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  secretName: string;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("Data Asset properties")
model DataContainerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  //  @doc("Data store properties")
  //  @visibility(Lifecycle.Read, Lifecycle.Create)
  //  dataStore: DataStore;

  @doc("The Azure storage account ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataStoreId: Azure.Core.armResourceIdentifier<[
    // TODO: Add type for Azure FileSystem
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The data store type.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataStoreType: DataStoreType;

  @doc("The settings for connecting to the database.")
  @visibility(Lifecycle.Read)
  databaseSettings?: DatabaseSettings;

  @doc("Credential to access the dataStore.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  credential: Credential;
}

@armResourceOperations
interface DataContainers {
  get is ArmResourceRead<DataContainer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataContainer>;
  update is ArmResourcePatchSync<DataContainer, DataContainerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataContainer>;
  listByResourceGroup is ArmResourceListByParent<DataContainer>;
  listBySubscription is ArmListBySubscription<DataContainer>;
}
