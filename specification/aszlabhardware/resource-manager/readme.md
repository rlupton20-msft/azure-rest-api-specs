# AszLabHardware

> see https://aka.ms/autorest

This is the AutoRest configuration file for AszLabHardware.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the AszLabHardware.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2024-06-01-preview
```

### Tag: package-2024-06-01-preview

These settings apply only when `--tag=package-2024-06-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-06-01-preview'
input-file:
  - Private.AszLabHardware/preview/2024-06-01-preview/openapi.json
```

### Tag: package-2024-05-15-preview

These settings apply only when `--tag=package-2024-05-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-15-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-15-preview/openapi.json
```

### Tag: package-2024-05-14-preview

These settings apply only when `--tag=package-2024-05-14-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-14-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-14-preview/openapi.json
```

### Tag: package-2024-05-13-preview

These settings apply only when `--tag=package-2024-05-13-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-13-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-13-preview/openapi.json
```

### Tag: package-2024-05-12-preview

These settings apply only when `--tag=package-2024-05-12-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-12-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-12-preview/openapi.json
```

### Tag: package-2024-05-11-preview

These settings apply only when `--tag=package-2024-05-11-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-11-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-11-preview/openapi.json
```

### Tag: package-2024-05-10-preview

These settings apply only when `--tag=package-2024-05-10-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-10-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-10-preview/openapi.json
```

### Tag: package-2024-05-09-preview

These settings apply only when `--tag=package-2024-05-09-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-09-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-09-preview/openapi.json
```

### Tag: package-2024-05-08-preview

These settings apply only when `--tag=package-2024-05-08-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-08-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-08-preview/openapi.json
```

### Tag: package-2024-05-07-preview

These settings apply only when `--tag=package-2024-05-07-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-07-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-07-preview/openapi.json
```

### Tag: package-2024-05-06-preview

These settings apply only when `--tag=package-2024-05-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-06-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-06-preview/openapi.json
```

### Tag: package-2024-05-05-preview

These settings apply only when `--tag=package-2024-05-05-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-05-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-05-preview/openapi.json
```

### Tag: package-2024-05-04-preview

These settings apply only when `--tag=package-2024-05-04-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-04-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-04-preview/openapi.json
```

### Tag: package-2024-05-03-preview

These settings apply only when `--tag=package-2024-05-03-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-03-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-03-preview/openapi.json
```

### Tag: package-2024-05-02-preview

These settings apply only when `--tag=package-2024-05-02-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-02-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-02-preview/openapi.json
```

### Tag: package-2024-05-01-preview

These settings apply only when `--tag=package-2024-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-05-01-preview'
input-file:
  - Private.AszLabHardware/preview/2024-05-01-preview/openapi.json
```

### Tag: package-2023-10-01-preview

These settings apply only when `--tag=package-2023-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-10-01-preview'
input-file:
  - Private.AszLabHardware/preview/2023-10-01-preview/openapi.json
```

### Tag: package-2023-09-01-preview

These settings apply only when `--tag=package-2023-09-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-09-01-preview'
input-file:
  - Private.AszLabHardware/preview/2023-09-01-preview/openapi.json
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
  - repo: azure-sdk-for-go
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
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