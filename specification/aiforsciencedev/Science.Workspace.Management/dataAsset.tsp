import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./workspace.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.AiForScience.Versions)
namespace Microsoft.AiForScience;

@doc("Data Asset tracked resource")
model DataAsset is TrackedResource<DataAssetProperties> {
  ...ResourceNameParameter<DataAsset>;
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

@doc("The Azure storage account ID.")
scalar StorageAccountId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts",
    }
  ]>;

////@discriminator("type")
//@doc("The Azure storage blob properties.")
//model AzureStorageBlob extends DataStore {
//  @visibility("read")
//  type: DataStoreType.AzureStorageBlob;
//
//  @doc("The associated azure storage account ID.")
//  @visibility("read", "create")
//  storageAccountId: StorageAccountId;
//}
//
////@discriminator("type")
//@doc("The Azure storage file properties.")
//model AzureStorageFile extends DataStore {
//  @visibility("read")
//  type: DataStoreType.AzureStorageFile;
//
//  @doc("The associated Azure storage file account name.")
//  @visibility("read", "create")
//  storageAccountName: string;
//}

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
  @visibility("read")
  type: CredentialType.ManagedIdentity;

  @doc("The managed identity client Id.")
  @visibility("read", "create", "update")
  clientId?: string;
}

@doc("SAS token credential properties")
model KeyVaultSecretCredential extends Credential {
  @visibility("read")
  type: CredentialType.KeyvaultSecret;

  @doc("The shared access token.")
  @visibility("read", "create", "update")
  secretName: string;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("Data Asset properties")
model DataAssetProperties {
  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  //  @doc("Data store properties")
  //  @visibility("read", "create")
  //  dataStore: DataStore;

  @doc("The Azure storage account ID.")
  @visibility("read", "create")
  storageAccountId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;

  @doc("The data store type.")
  dataStoreType: DataStoreType;

  @doc("Credential to access the dataStore.")
  @visibility("read", "create", "update")
  credential: Credential;
}

@armResourceOperations
interface DataAssets {
  get is ArmResourceRead<DataAsset>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataAsset>;
  update is ArmResourcePatchSync<DataAsset, DataAssetProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataAsset>;
  listByResourceGroup is ArmResourceListByParent<DataAsset>;
  listBySubscription is ArmListBySubscription<DataAsset>;
}
