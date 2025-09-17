# devcenter

> see https://aka.ms/autorest
This is the AutoRest configuration file for devcenter.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the devcenter.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2025-08-01
eol: crlf
```

### Tag: package-preview-2025-08-01-preview

These settings apply only when `--tag=package-preview-2025-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-08-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2025-08-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2025-08-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2025-08-01-preview/vdi.json
```

### Tag: package-preview-2025-04-01-preview

These settings apply only when `--tag=package-preview-2025-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-04-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2025-04-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2025-04-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2025-04-01-preview/vdi.json
```

### Tag: package-preview-2025-03-01-preview

These settings apply only when `--tag=package-preview-2025-03-01-preview` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2025-03-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2025-03-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2025-03-01-preview/vdi.json
```

### Tag: package-2025-02-01

These settings apply only when `--tag=package-2025-02-01` is specified on the command line.

```yaml $(tag) == 'package-2025-02-01'
input-file:
  - Microsoft.DevCenter/stable/2025-02-01/commonDefinitions.json
  - Microsoft.DevCenter/stable/2025-02-01/devcenter.json
  - Microsoft.DevCenter/stable/2025-02-01/vdi.json
```

### Tag: package-preview-2024-10

These settings apply only when `--tag=package-preview-2024-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-10'
input-file:
  - Microsoft.DevCenter/preview/2024-10-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2024-10-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2024-10-01-preview/vdi.json
```

### Tag: package-preview-2024-08

These settings apply only when `--tag=package-preview-2024-08` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-08'
input-file:
  - Microsoft.DevCenter/preview/2024-08-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2024-08-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2024-08-01-preview/vdi.json
```

### Tag: package-preview-2024-06

These settings apply only when `--tag=package-preview-2024-06` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06'
input-file:
  - Microsoft.DevCenter/preview/2024-06-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2024-06-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2024-06-01-preview/vdi.json
```

### Tag: package-preview-2024-05

These settings apply only when `--tag=package-preview-2024-05` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-05'
input-file:
  - Microsoft.DevCenter/preview/2024-05-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2024-05-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2024-05-01-preview/vdi.json
```

### Tag: package-2024-02

These settings apply only when `--tag=package-2024-02` is specified on the command line.

```yaml $(tag) == 'package-2024-02'
input-file:
  - Microsoft.DevCenter/stable/2024-02-01/commonDefinitions.json
  - Microsoft.DevCenter/stable/2024-02-01/devcenter.json
  - Microsoft.DevCenter/stable/2024-02-01/vdi.json
```
### Tag: package-preview-2023-11

These settings apply only when `--tag=package-preview-2023-11` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-11'
input-file:
  - Microsoft.DevCenter/preview/2023-11-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2023-11-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-11-01-preview/vdi.json
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-09'
input-file:
  - Microsoft.DevCenter/preview/2023-09-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2023-09-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-09-01-preview/vdi.json
```

### Tag: package-preview-2023-01

These settings apply only when `--tag=package-preview-2023-01` is specified on the command line.

``` yaml $(tag) == 'package-preview-2023-01'
input-file:
  - Microsoft.DevCenter/preview/2023-01-01-preview/commonDefinitions.json
  - Microsoft.DevCenter/preview/2023-01-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-01-01-preview/vdi.json
```

### Tag: v2022-03-01-privatepreview

These settings apply only when `--tag=2022-03-01-privatepreview` is specified on the command line.

``` yaml $(tag) == 'v2022-03-01-privatepreview'
input-file:
  - Microsoft.DevCenter/preview/2022-03-01-privatepreview/devcenter.json
  - Microsoft.DevCenter/preview/2022-03-01-privatepreview/vdi.json
```

### Tag: v2022-08-01-preview

These settings apply only when `--tag=2022-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'v2022-08-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2022-08-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2022-08-01-preview/vdi.json
```

### Tag: v2022-09-01-preview

These settings apply only when `--tag=2022-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'v2022-09-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2022-09-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2022-09-01-preview/vdi.json
```

### Tag: v2022-10-12-preview

These settings apply only when `--tag=2022-10-12-preview` is specified on the command line.

``` yaml $(tag) == 'v2022-10-12-preview'
input-file:
  - Microsoft.DevCenter/preview/2022-10-12-preview/devcenter.json
  - Microsoft.DevCenter/preview/2022-10-12-preview/vdi.json
```

### Tag: v2022-11-11-preview

These settings apply only when `--tag=2022-11-11-preview` is specified on the command line.

``` yaml $(tag) == 'v2022-11-11-preview'
input-file:
  - Microsoft.DevCenter/preview/2022-11-11-preview/devcenter.json
  - Microsoft.DevCenter/preview/2022-11-11-preview/vdi.json
```

### Tag: v2023-04-01

These settings apply only when `--tag=2023-04-01` is specified on the command line.

``` yaml $(tag) == 'v2023-04-01'
input-file:
  - Microsoft.DevCenter/preview/2023-04-01/devcenter.json
  - Microsoft.DevCenter/preview/2023-04-01/vdi.json
```

### Tag: v2023-06-01-preview

These settings apply only when `--tag=2023-06-01-preview` is specified on the command line.

``` yaml $(tag) == 'v2023-06-01-preview'
input-file:
  - Microsoft.DevCenter/preview/2023-06-01-preview/devcenter.json
  - Microsoft.DevCenter/preview/2023-06-01-preview/vdi.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_devcenter']
```

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Powershell

See configuration in [readme.powershell.md](./readme.powershell.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)
