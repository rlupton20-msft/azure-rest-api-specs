## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az) && $(target-mode) != 'core'
az:
  extensions: storageconnectors
  namespace: azure-mgmt-storageconnectors
  package-name: azure.mgmt.storageconnectors
az-output-folder: $(azure-cli-extension-folder)/src/storageconnectors
python-sdk-output-folder: "$(az-output-folder)/azext_storageconnectors/vendored_sdks/storageconnectors"
```

<!-- Use this once onboarded to the azure cli main repo.
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: storageconnectors
  namespace: private.storageconnectors
  package-name: private.storageconnectors
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/storageconnectors
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/storageconnectors"
```  -->