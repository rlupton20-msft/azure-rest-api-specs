# Trusted Signing

> see https://aka.ms/autorest

This is the AutoRest configuration file for Code Signing service.

## Getting Started

To build the SDKs for Connected Cluster API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.
---

## Configuration

### Basic Information

These are the global settings for the CodeSigning API.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-11-20-preview
```

### Tag: package-2025-11-20-preview

These settings apply only when `--tag=package-2025-11-20-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-11-20-preview'
input-file:
- Microsoft.CodeSigning/preview/2025-11-20-preview/codeSigningAccount.json
```

### Tag: package-2025-10-13

These settings apply only when `--tag=package-2025-10-13` is specified on the command line.

```yaml $(tag) == 'package-2025-10-13'
input-file:
- Microsoft.CodeSigning/stable/2025-10-13/codeSigningAccount.json
```

### Tag: package-2024-09-30-preview

These settings apply only when `--tag=package-2024-09-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-09-30-preview'
input-file:
- Microsoft.CodeSigning/preview/2024-09-30-preview/codeSigningAccount.json
```

### Tag: package-2024-02-05-preview

These settings apply only when `--tag=package-2024-02-05-preview` is specified on the command line.

```yaml $(tag) == 'package-2024-02-05-preview'
input-file:
- Microsoft.CodeSigning/preview/2024-02-05-preview/codeSigningAccount.json
```

### Tag: package-2023-04-30-preview

These settings apply only when `--tag=package-2023-04-30-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-30-preview'
input-file:
- Microsoft.CodeSigning/preview/2023-04-30-preview/codeSigningAccount.json
```

### Tag: package-2020-12-14-preview

These settings apply only when `--tag=package-2020-12-14-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-12-14-preview'
input-file:
- Microsoft.CodeSigning/preview/2020-12-14-preview/codeSigningAccount.json
```


---



