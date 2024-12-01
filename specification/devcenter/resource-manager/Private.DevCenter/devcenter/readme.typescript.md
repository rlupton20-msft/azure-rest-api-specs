## TypeScript

These settings apply only when `--typescript` is specified on the command line.

```yaml $(typescript)
typescript:
  azure-arm: true
  package-name: "devcenter"
  output-folder: "$(typescript-sdks-folder)/$(tag)/"
  payload-flattening-threshold: 1
  generate-metadata: true
  enum-types: true
directive:
- from: "code-model-v1"
  where: $.operations
  transform: return undefined
```

