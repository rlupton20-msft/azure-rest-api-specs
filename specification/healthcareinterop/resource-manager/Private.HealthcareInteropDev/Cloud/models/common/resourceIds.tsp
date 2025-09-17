alias StorageAccountResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Storage/storageAccounts";
  }
]>;

alias KeyVaultResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.KeyVault/vaults";
  }
]>;

alias HubResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/hubs";
  }
]>;

alias Hl7ConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/hl7Connectors";
  }
]>;

alias DdmsConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/ddmsConnectors";
  }
]>;

alias Hl7EdgeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/hl7EdgeConnectors";
  }
]>;

alias DicomConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/dicomConnectors";
  }
]>;

alias DicomEdgeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/dicomEdgeConnectors";
  }
]>;

alias StorageAccountConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/storageAccountConnectors";
  }
]>;

alias OneLakeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropDev/oneLakeConnectors";
  }
]>;

alias ConnectedClusterResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Kubernetes/connectedClusters";
  }
]>;

alias HealthcareExtensionResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.Kubernetes/connectedClusters/Microsoft.KubernetesConfiguration/extensions";
  }
]>;

alias CustomLocationResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Microsoft.ExtendedLocation/customLocations";
  }
]>;
