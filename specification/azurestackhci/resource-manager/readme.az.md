## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: azurestackhci
    namespace: azure.mgmt.azurestackhci
    package-name: azure-mgmt-azurestackhci
az-output-folder: $(azure-cli-extension-folder)/src/azurestackhci
python-sdk-output-folder: "$(az-output-folder)/azext_azurestackhci/vendored_sdks/azurestackhci"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
