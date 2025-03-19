import "@azure-tools/typespec-azure-core";

using Azure.Core;

@doc("The resource ID of a storage account.")
scalar StorageAccountResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts",
    }
  ]>;

@doc("The resource ID of a key vault.")
scalar KeyVaultResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.KeyVault/vaults",
    }
  ]>;
