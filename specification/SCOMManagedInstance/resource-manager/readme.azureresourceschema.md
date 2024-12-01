## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-SCOMManagedInstance-2020-11-30-preview

```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-SCOMManagedInstance-2020-11-30-preview and azureresourceschema

``` yaml $(tag) == 'schema-SCOMManagedInstance-2020-11-30-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.SCOMManagedInstance/preview/2020-11-30-preview/managedinstance.json

```
