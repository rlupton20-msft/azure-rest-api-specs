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
    type: "Private.HealthcareInteropInt/hubs";
  }
]>;

alias Hl7ConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/hl7Connectors";
  }
]>;

alias Hl7EdgeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/hl7EdgeConnectors";
  }
]>;

alias DicomConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/dicomConnectors";
  }
]>;

alias DicomEdgeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/dicomEdgeConnectors";
  }
]>;

alias StorageAccountConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/storageAccountConnectors";
  }
]>;

alias OneLakeConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/oneLakeConnectors";
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

alias DdmsConnectorResourceId = Azure.Core.armResourceIdentifier<[
  {
    type: "Private.HealthcareInteropInt/ddmsConnectors";
  }
]>;
