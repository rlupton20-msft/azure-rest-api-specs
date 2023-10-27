## AzureResourceSchema

These settings apply only when `--azureresourceschema` is specified on the command line.

### AzureResourceSchema multi-api

``` yaml $(azureresourceschema) && $(multiapi)
batch:
  - tag: schema-testbase-2020-12-16-preview
  - tag: schema-testbase-2021-12-16-preview
  
```

Please also specify `--azureresourceschema-folder=<path to the root directory of your azure-resource-manager-schemas clone>`.

### Tag: schema-testbase-2020-12-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2020-12-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBaseBin/preview/2020-12-16-preview/testbase.json
```

### Tag: schema-testbase-2021-12-16-preview and azureresourceschema

``` yaml $(tag) == 'schema-testbase-2021-12-16-preview' && $(azureresourceschema)
output-folder: $(azureresourceschema-folder)/schemas

# all the input files in this apiVersion
input-file:
  - Microsoft.TestBaseBin/preview/2021-12-16-preview/testbase.json
```

### Tag: package-2022-12-15-preview and azureresourceschema

These settings apply only when `--tag=package-2022-12-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-12-15-preview' && $(azureresourceschema)
input-file:
  - Microsoft.TestBaseBin/preview/2022-12-15-preview/testbase.json
  - Microsoft.TestBaseBin/preview/2022-12-15-preview/draftpackage.json
```