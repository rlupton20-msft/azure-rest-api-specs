## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: redoak
    namespace: azure.mgmt.redoak
    package-name: azure-mgmt-redoak
az-output-folder: $(azure-cli-extension-folder)/src/redoak
python-sdk-output-folder: "$(az-output-folder)/azext_redoak/vendored_sdks/redoak"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```



This is for command modules that already in azure cli main repo. 
``` yaml $(az) && $(target-mode) == 'core'
az:
  extensions: redoak
  namespace: azure.mgmt.redoak
  package-name: azure-mgmt-redoak
az-output-folder: $(azure-cli-folder)/src/azure-cli/azure/cli/command_modules/redoak
python-sdk-output-folder: "$(az-output-folder)/vendored_sdks/redoak"
``` 