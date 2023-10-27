## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
  azure-arm: true
  extensions: aksedge
  namespace: Microsoft.WatchListoperator
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  package-name: azure-mgmt-aksedge
  clear-output-folder: true
az-output-folder: $(azure-cli-extension-folder)/src/aksedge
```
