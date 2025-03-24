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

@doc("The resource ID of a healthcare interop hl7Connector resource.")
scalar Hl7ConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/hl7Connectors",
    }
  ]>;

@doc("The resource ID of a healthcare interop storageAccountConnector resource.")
scalar StorageAccountConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/storageAccountConnectors",
    }
  ]>;

@doc("The resource ID of a healthcare interop oneLakeConnector resource.")
scalar OneLakeConnectorResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Private.HealthcareInteropDev/oneLakeConnectors",
    }
  ]>;

@doc("The resource ID of a Kubernetes connected cluster.")
scalar ConnectedClusterResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters",
    }
  ]>;

@doc("The resource ID of the healthcare extension.")
scalar HealthcareExtensionResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Kubernetes/connectedClusters/Microsoft.KubernetesConfiguration/extensions",
    }
  ]>;

@doc("The resource ID of the custom location resource.")
scalar CustomLocationResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ExtendedLocation/customLocations",
    }
  ]>;
