## AZ

These settings apply only when `--az` is specified on the command line.

``` yaml $(az)
az:
    extensions: azsdevicecom
    namespace: azure.mgmt.azsdevicecom
    package-name: azure-mgmt-azsdevicecom
az-output-folder: $(azure-cli-extension-folder)/src/azsdevicecom
python-sdk-output-folder: "$(az-output-folder)/azext_azurestackhci/vendored_sdks/azsdevicecom"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```
