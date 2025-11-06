# deviceregistry

> see https://aka.ms/autorest

This is the AutoRest configuration file for deviceregistry.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the deviceregistry.

```yaml
openapi-type: arm
tag: package-preview-2025-11
```

### Tag: package-preview-2025-11
These settings apply only when `--tag=package-preview-2025-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2025-11'
input-file:
  - Private.DeviceRegistry/preview/2025-11-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.events
      - $.definitions.NamespaceAssetUpdateProperties.properties.events
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.events
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.events
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.deviceTemplateId
      - $.definitions.NamespaceDeviceProperties.properties.deviceGroupId
      - $.definitions.NamespaceDeviceUpdateProperties.properties.deviceTemplateId
      - $.definitions.NamespaceDeviceUpdateProperties.properties.deviceGroupId
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: Customer-defined properties and new API features
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-2025-10
These settings apply only when `--tag=package-2025-10` is specified on the command line.

``` yaml $(tag) == 'package-2025-10'
input-file:
  - Private.DeviceRegistry/stable/2025-10-01/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2025-08
These settings apply only when `--tag=package-preview-2025-08` is specified on the command line.

``` yaml $(tag) == 'package-preview-2025-08'
input-file:
  - Private.DeviceRegistry/preview/2025-08-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.events
      - $.definitions.NamespaceAssetUpdateProperties.properties.events
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.events
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.events
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.NamespaceDeviceProperties.properties.deviceTemplateId
      - $.definitions.NamespaceDeviceProperties.properties.deviceGroupId
      - $.definitions.NamespaceDeviceUpdateProperties.properties.deviceTemplateId
      - $.definitions.NamespaceDeviceUpdateProperties.properties.deviceGroupId
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
    reason: Customer-defined properties and new API features
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-preview-2025-07
These settings apply only when `--tag=package-preview-2025-07` is specified on the command line.

``` yaml $(tag) == 'package-preview-2025-07'
input-file:
  - Private.DeviceRegistry/preview/2025-07-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetProperties.properties.attributes
      - $.definitions.NamespaceDiscoveredAssetUpdateProperties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.NamespaceDeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.inbound
      - $.definitions.MessagingEndpointsUpdate.properties.inbound
      - $.definitions.OutboundEndpoints.properties.assigned
      - $.definitions.OutboundEndpoints.properties.unassigned
      - $.definitions.OutboundEndpointsUpdate.properties.assigned
      - $.definitions.OutboundEndpointsUpdate.properties.unassigned
      - $.definitions.NamespaceDiscoveredDeviceProperties.properties.attributes
      - $.definitions.DiscoveredMessagingEndpoints.properties.inbound
      - $.definitions.DiscoveredMessagingEndpointsUpdate.properties.inbound
      - $.definitions.DiscoveredOutboundEndpoints.properties.assigned
      - $.definitions.DiscoveredOutboundEndpointsUpdate.properties.assigned
      - $.definitions.DeviceStatusEndpoints.properties.inbound
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Private.DeviceRegistry/schemaRegistries/{schemaRegistryName}/schemas"].get.operationId
```

### Tag: package-2024-11

These settings apply only when `--tag=package-2024-11` is specified on the command line.

```yaml $(tag) == 'package-2024-11'
input-file:
  - Private.DeviceRegistry/stable/2024-11-01/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: The property is generated by TypeSpec compiler
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - Private.DeviceRegistry/preview/2024-10-01-preview/deviceregistry.json
suppressions:
  - code: XmsExamplesRequired
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: RequiredPropertiesMissingInResourceModel
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: AvoidAdditionalProperties
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: ResponseSchemaSpecifiedForSuccessStatusCode
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: ValidResponseCodeRequired
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: XMS_EXAMPLE_NOTFOUND_ERROR
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: OBJECT_MISSING_REQUIRED_PROPERTY
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: OBJECT_ADDITIONAL_PROPERTIES
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: RESPONSE_STATUS_CODE_NOT_IN_SPEC
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: RESPONSE_STATUS_CODE_NOT_IN_EXAMPLE
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: REQUIRED_PARAMETER_EXAMPLE_NOT_FOUND
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future.
  - code: RESPONSE_SCHEMA_NOT_IN_SPEC
    from: 
      - deviceregistry.json
    reason: This api version will be removed in the future. 
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.NamespaceAssetProperties.properties.attributes
      - $.definitions.NamespaceAssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
      - $.definitions.Messaging.properties.endpoints
      - $.definitions.MessagingEndpoints.properties.assigned
      - $.definitions.MessagingEndpoints.properties.unassigned
      - $.definitions.MessagingEndpointsUpdate.properties.assigned
      - $.definitions.MessagingEndpointsUpdate.properties.unassigned
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: The property is generated by TypeSpec compiler
```

### Tag: package-preview-2024-09

These settings apply only when `--tag=package-preview-2024-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09'
input-file:
  - Private.DeviceRegistry/preview/2024-09-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: The property is generated by TypeSpec compiler
```

### Tag: package-preview-2024-07

These settings apply only when `--tag=package-preview-2024-07` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-07'
input-file:
  - Private.DeviceRegistry/preview/2024-07-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: OperationIdNounVerb
    from:
      - deviceregistry.json
    reason: An existing resource type is called 'schemas'
  - code: PatchBodyParametersSchema
    from:
      - deviceregistry.json
    reason: The property is generated by TypeSpec compiler
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Private.DeviceRegistry/preview/2024-05-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Private.DeviceRegistry/preview/2023-11-01-preview/deviceregistry.json
suppressions:
  - code: AvoidAdditionalProperties
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
  - code: PropertiesTypeObjectNoDefinition
    from:
      - deviceregistry.json
    where:
      - $.definitions.Asset.properties.properties.properties.attributes
      - $.definitions.AssetListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.AssetProperties.properties.attributes
      - $.definitions.AssetUpdate.properties.properties.properties.attributes
      - $.definitions.AssetUpdateProperties.properties.attributes
      - $.definitions.Device.properties.properties.properties.attributes
      - $.definitions.DeviceListResult.properties.value.items.properties.properties.properties.attributes
      - $.definitions.DeviceBaseProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Private.DeviceRegistry/preview/2023-10-01-preview/assetSchemas.json
  - Private.DeviceRegistry/preview/2023-10-01-preview/assetendpointprofiles.json
  - Private.DeviceRegistry/preview/2023-10-01-preview/assetnestedrelationship.json
  - Private.DeviceRegistry/preview/2023-10-01-preview/assets.json
  - Private.DeviceRegistry/preview/2023-10-01-preview/devices.json
  - Private.DeviceRegistry/preview/2023-10-01-preview/schemaregistry.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Private.DeviceRegistry/preview/2023-09-01-preview/assetnestedrelationship.json
  - Private.DeviceRegistry/preview/2023-09-01-preview/assets.json
  - Private.DeviceRegistry/preview/2023-09-01-preview/devices.json
```

### Tag: package-preview-2021-10-10

These settings apply only when `--tag=package-preview-2021-10-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-10-10'
input-file:
  - Private.DeviceRegistry/preview/2021-10-10-preview/deviceregistry.json
```

### Tag: package-preview-2021-10

These settings apply only when `--tag=package-preview-2021-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2021-10'
input-file:
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/asset.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/assetEndpointProfiles.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/assetTypes.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/assetnestedrelationship.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/deviceGroup.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/nested.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/nestedmembers.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/scaletest.json
  - Microsoft.IoTWorkspaces/preview/2021-10-10-alpha/workspace.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python-track2
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
