# Data Services for Financial Cloud

> see https://aka.ms/autorest
This is the AutoRest configuration file for Data Services for Financial Cloud.

---

## Getting Started

To build the SDK for Security, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`
To see additional help and options, run:

> `autorest --help`
---

## Configuration

## Suppression

``` yaml
directive:
```

### Basic Information

These are the global settings for the IoT Security API.

``` yaml
title: FinancialDataServices
description: API spec for Microsoft.FinancialDataServices resource provider
openapi-type: arm
openapi-subtype: rpaas
tag: 2022-10-12-preview
```

### Tag: 2022-10-12-preview

These settings apply only when `--tag=2022-10-12-preview` is specified on the command line.

```yaml $(tag) == '2022-10-12-preview'
input-file:
- Microsoft.FinancialDataServices/preview/2022-10-12-preview/openapi.json
```

``` yaml
title: FinancialDataServices
description: API spec for Microsoft.FinancialDataServices resource provider
openapi-type: arm
tag: 2022-10-12-preview
```