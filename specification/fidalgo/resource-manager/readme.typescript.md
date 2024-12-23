## TypeScript

These settings apply only when `--typescript` is specified on the command line.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "fidalgo"
  output-folder: "$(typescript-sdks-folder)/$(tag)/"
  payload-flattening-threshold: 1
  generate-metadata: true
  enum-types: true
directive:
- from: "code-model-v1"
  where: $.operations
  transform: return undefined
```

``` yaml $(types-only)
typescript:
  package-name: "fidalgo-types"
  enum-types: false
directive:
  - from: 'swagger-document'
    where: $.paths.*
    transform: >-
      $ = undefined

  - from: swagger-document
    where: "$.definitions.*.properties.properties"
    transform: >-
      $["x-ms-client-flatten"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.CatalogItemEngineProperties.properties.type"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.IdentityProperties.properties.type"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.EnableStatus"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.MachineDefinitionUpdateProperties.properties.imageType"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.Sku.properties.tier"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.Identity.type"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.systemData.properties.createdByType"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.systemData.properties.lastModifiedByType"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.encryptionProperties.properties.status"
    transform: >-
      $["x-ms-enum"]["modelAsString"] = false;
      return $;
```