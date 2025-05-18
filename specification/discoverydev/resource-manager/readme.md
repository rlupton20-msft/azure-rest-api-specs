# Azure Discovery

> see https://aka.ms/autorest
> This is the AutoRest configuration file for Azure Discovery.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`
> To see additional help and options, run:

> `autorest --help`
> For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the Azure Discovery.

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-07-01-preview
```

### Tag: package-2025-07-01-preview

These settings apply only when `--tag=package-2025-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-07-01-preview'
input-file:
  - Private.Discovery/preview/2025-07-01-preview/discovery.json
suppressions:
  - code: AvoidAnonymousTypes
    from: discovery.json
    reason: Swagger LintDiff false positive for ManagedServiceIdentityProperty
  - code: LatestVersionOfCommonTypesMustBeUsed
    from: discovery.json
    reason: Newer version no longer has MoboConfigurationWithMrg
  - code: GetCollectionResponseSchema
    reason: The contents of the definitionContent property is excessively large, not suitable for list response.
    from:
      - discovery.json
    where:
      - $.paths["/subscriptions/{subscriptionId}/providers/Private.Discovery/agents"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Private.Discovery/models"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Private.Discovery/tools"]
      - $.paths["/subscriptions/{subscriptionId}/providers/Private.Discovery/workflows"]
  - code: AvoidAdditionalProperties
    reason: Enable customer to apply environment variables.
    from:
      - discovery.json
    where: 
      - $.definitions.ToolProperties.properties.environmentVariables
      - $.definitions.ToolListItemProperties.properties.environmentVariables
      - $.definitions.ToolPropertiesUpdate.properties.environmentVariables
  - code: AvoidAdditionalProperties
    reason: Enable customer to assign identities to tools.
    from:
      - discovery.json
    where:
      - $.definitions.SupercomputerIdentities.properties.workloadIdentities
      - $.definitions.SupercomputerIdentitiesUpdate.properties.workloadIdentities
  - code: GuidUsage
    reason: Refers to clientId from Azure.ResourceManager.CommonTypes.UserAssignedIdentity.
    from:
      - discovery.json
```

---
