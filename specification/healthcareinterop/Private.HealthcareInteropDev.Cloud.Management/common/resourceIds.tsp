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

@doc("The resource ID of a healthcare interop hub resource.")
scalar HubResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hubs",
    }
  ]>;

@doc("The resource ID of a healthcare interop hl7connector resource.")
scalar Hl7ConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hl7connectors",
    }
  ]>;

@doc("The resource ID of a healthcare interop storageaccountconnector resource.")
scalar StorageAccountConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/storageaccountconnectors",
    }
  ]>;

@doc("The resource ID of a healthcare interop onelakeconnector resource.")
scalar OneLakeConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/onelakeconnectors",
    }
  ]>;
