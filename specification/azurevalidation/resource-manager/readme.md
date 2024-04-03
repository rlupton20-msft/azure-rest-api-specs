# contoso

> see https://aka.ms/autorest

This is the AutoRest configuration file for Microsoft.AzureValidation.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the contoso.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-04-01-preview
```

### Tag: package-2024-04-01-preview

These settings apply only when `--tag=package-package-2024-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-04-01-preview'
input-file:
  - Microsoft.AzureValidation/preview/2024-04-01-preview/azurevalidation.json
```

## Suppression

``` yaml
directive:
  - suppress: RequiredReadOnlySystemData
    from: cnab.json
    reason: This is an RPaaS Bridge type
```

## AzureResourceSchema

See configuration in [readme.azureresourceschema.md](./readme.azureresourceschema.md)