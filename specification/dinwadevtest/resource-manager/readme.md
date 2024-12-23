# Microsoft.Contoso

> see https://aka.ms/autorest
This is the AutoRest configuration file for Contoso.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
To see additional help and options, run:

> `autorest --help`
For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Microsoft.Contoso.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2021-10-01-preview
```

### Suppressions

```yaml
suppressions:
  - code: unsupported-versioning-decorator
```

### Tag: package-package-2021-08-01-preview

These settings apply only when `--tag=package-2021-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-10-01-preview'
input-file:
  - Microsoft.Contoso/preview/2021-10-01-preview/openapi.json
```

### Tag: package-package-canonical

These settings apply only when `--tag=package-canonical` is specified on the command line.

```yaml $(tag) == 'package-canonical'
input-file:
  - Microsoft.Contoso/canonical/openapi.json

suppressions:
  - code: APIVersionPattern
    from: openapi.json
    reason: Canonical version is valid
```

### Suppression

``` yaml
directive:
  - suppress: BodyTopLevelProperties
    from: openapi.json
```

---

# Code Generation