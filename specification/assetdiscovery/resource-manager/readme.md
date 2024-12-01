# AssetDiscovery

> see https://aka.ms/autorest

This is the AutoRest configuration file for AssetDiscovery.

---

## Getting Started

To build the SDK for AssetDiscovery, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the AssetDiscovery API.

``` yaml
openapi-type: arm
tag: package-2024-04-24-preview
```

### Tag: package-2024-04-24-preview

These settings apply only when `--tag=package-2024-04-24-preview` is specified on the command line.

``` yaml $(tag) == 'package-2024-04-24-preview'
input-file:
- Microsoft.AssetDiscovery/preview/2024-04-24-preview/assetdiscovery.json
```