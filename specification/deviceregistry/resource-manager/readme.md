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
tag: package-preview-2024-05
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Microsoft.DeviceRegistry/preview/2024-05-01-preview/deviceregistry.json
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
      - $.definitions.DeviceProperties.properties.attributes
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
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - Microsoft.DeviceRegistry/preview/2024-03-01-preview/deviceregistry.json
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
      - $.definitions.DeviceProperties.properties.attributes
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
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-11-01-preview/deviceregistry.json
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
      - $.definitions.DeviceProperties.properties.attributes
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
      - $.definitions.DeviceProperties.properties.attributes
      - $.definitions.DeviceUpdate.properties.properties.properties.attributes
      - $.definitions.DeviceUpdateProperties.properties.attributes
    reason: attributes is a customer-defined property of any shape
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-10-01-preview/asset.json
  - Microsoft.DeviceRegistry/preview/2023-10-01-preview/assetEndpointProfiles.json
  - Microsoft.DeviceRegistry/preview/2023-10-01-preview/devices.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.DeviceRegistry/preview/2023-09-01-preview/asset.json
  - Microsoft.DeviceRegistry/preview/2023-09-01-preview/devices.json
```

### Tag: package-2022-04-04-preview

These settings apply only when `--tag=package-2022-04-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-04-04-preview'
input-file:
  - Private.Devices/preview/2022-04-04-preview/deviceregistry.json
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
