# loadtestservice

> see https://aka.ms/autorest

This is the AutoRest configuration file for loadtestservice.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the loadtestservice.

``` yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-preview-2023-12
```

## Suppression

```yaml
directive:
  - suppress: NoDuplicatePathsForScopeParameter
    from: loadtestservice.json
    reason: They are two different APIs.( loadtestMappings and loadTestMappings/loadtestMappingName)
```
### Tag: package-2025-07-01-preview
These settings apply only when `--tag=2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - Microsoft.LoadTestService/Playwright.Management/preview/2025-07-01-preview/playwright.json
suppressions:
  - code: PatchBodyParametersSchema
    from: playwright.json
    reason: Seems like a tool bug, as the operations are generated automatically from the TrackedResourceOperations in the TypeSpec which should OmitDefaults for Patch. We want the default property values to be visible for other operations like Put and Get if they're not explicitly set by the end-user.
  - code: DeleteResponseCodes
    from: playwright.json
    reason: Seems like a tool bug, as default operations with codes are generated from the TrackedResourceOperations in the TypeSpec.
    where:
      - $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.LoadTestService/playwrightWorkspaces/{playwrightWorkspaceName}"].delete
```

### Tag: package-preview-2023-12

These settings apply only when `--tag=package-preview-2023-12` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-12'
input-file:
  - Microsoft.LoadTestService/preview/2023-12-01-preview/loadtestservice.json
```
### Tag: package-2022-12-01

These settings apply only when `--tag=package-2022-12-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-12-01'
input-file:
  - Microsoft.LoadTestService/stable/2022-12-01/loadtestservice.json
```

### Tag: package-2022-09-01-preview

These settings apply only when `--tag=package-2022-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-09-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-09-01-preview/loadtestservice.json
```

### Tag: package-2022-08-01-preview

These settings apply only when `--tag=package-2022-08-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-08-01-preview/loadtestservice.json
```

### Tag: package-2022-04-15-preview

These settings apply only when `--tag=package-2022-04-15-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-04-15-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-04-15-preview/loadtestservice.json
```

### Tag: package-2022-04-01-preview

These settings apply only when `--tag=package-2022-04-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-04-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-04-01-preview/loadtestservice.json
```

### Tag: package-2022-03-01-preview

These settings apply only when `--tag=package-2022-03-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-03-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2022-03-01-preview/loadtestservice.json
```

### Tag: package-2021-12-01-preview

These settings apply only when `--tag=package-2021-12-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-12-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2021-12-01-preview/loadtestservice.json
```

### Tag: package-2021-11-01-preview

These settings apply only when `--tag=package-2021-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-11-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2021-11-01-preview/loadtestservice.json
```

### Tag: package-2021-09-01-preview

These settings apply only when `--tag=package-2021-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-09-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2021-09-01-preview/loadtestservice.json
```

### Tag: package-2020-09-01-preview

These settings apply only when `--tag=package-2020-09-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-09-01-preview'
input-file:
  - Microsoft.LoadTestService/preview/2020-09-01-preview/loadtestservice.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

``` yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go-track2
  - repo: azure-sdk-for-js
  - repo: azure-sdk-for-ruby
    after_scripts:
      - bundle install && rake arm:regen_all_profiles['azure_mgmt_loadtesting']
```

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## Ruby

See configuration in [readme.ruby.md](./readme.ruby.md)

## TypeScript

See configuration in [readme.typescript.md](./readme.typescript.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)
