## TypeScript

These settings apply only when `--typescript` is specified on the command line.
Please also specify `--typescript-sdks-folder=<path to the root directory of your azure-sdk-for-js clone>`.

``` yaml $(typescript)
typescript:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  package-name: "@azure/privatefootprintMonitoring"
  output-folder: "$(typescript-sdks-folder)/packages/@azure/privatefootprintMonitoring"
  clear-output-folder: true
  generate-metadata: true
```