import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

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

@doc("The kind of the backing data store.")
union DataStoreType {
  @doc("The Azure storage blob kind.")
  AzureStorageBlob: "AzureStorageBlob",

  @doc("The Azure storage file kind.")
  AzureStorageFile: "AzureStorageFile",

  string,
}

/** For associated azure storage account ID */
model WithStorageAccountId {
  @doc("The associated azure storage account ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  storageAccountId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

@discriminator("kind")
@doc("An abstract representation of data store kind.")
model DataStore {
  @doc("The data store kind.")
  kind: DataStoreType;
}

// @discriminator("kind")
@doc("The Azure storage blob properties.")
model AzureStorageBlob extends DataStore {
  /** Azure Storage Blob */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: DataStoreType.AzureStorageBlob;

  ...WithStorageAccountId;
}

@doc("The Azure storage file properties.")
model AzureStorageFile extends DataStore {
  /** Azure Storage File */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  // @discriminator("kind")
  kind: DataStoreType.AzureStorageFile;

  ...WithStorageAccountId;

  /** The name of the file share */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  fileShareName: string;
}

@doc("The kind of the credential used for RBAC against the data store.")
union CredentialType {
  @doc("Managed identity credential kind.")
  ManagedIdentity: "ManagedIdentity",

  @doc("Secret stored in KeyVault secret kind.")
  KeyVaultSecret: "KeyVaultSecret",

  string,
}

@discriminator("kind")
@doc("An abstract representation of data store kind.")
model Credential {
  /** Name of credential */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  @doc("The data store kind.")
  kind: CredentialType;

  ...WithDescription;
}

@doc("The managed identity credential properties.")
model ManagedIdentityCredential extends Credential {
  @visibility(Lifecycle.Read)
  kind: CredentialType.ManagedIdentity;

  @doc("The managed identity client Id.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  clientId?: string;
}

@doc("SAS token credential properties")
model KeyVaultSecretCredential extends Credential {
  @visibility(Lifecycle.Read)
  kind: CredentialType.KeyVaultSecret;

  @doc("The shared access token.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  secretName: string;
}

// #suppress "@azure-tools/typespec-autorest/union-unsupported"
@doc("Data Asset properties")
model DataContainerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Data store properties")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataStore: DataStore;

  @doc("Credential to access the dataStore.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  @minItems(1)
  credentials: Credential[];
}

@armResourceOperations
interface DataContainers {
  get is ArmResourceRead<DataContainer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DataContainer>;
  update is ArmResourcePatchAsync<DataContainer, DataContainerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<DataContainer>;
  listByResourceGroup is ArmResourceListByParent<DataContainer>;
  listBySubscription is ArmListBySubscription<DataContainer>;
}
