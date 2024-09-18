## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: qualitychecktemplate
    namespace: azure.mgmt.workloads.qualitychecktemplate
    package-name: azure-mgmt-workloads-qualitychecktemplate
az-output-folder: $(azure-cli-extension-folder)/src/workloads/qualitychecktemplate
python-sdk-output-folder: "$(az-output-folder)/azext_workloads/vendored_sdks/workloads/qualitychecktemplate"
# add additional configuration here specific for Azure CLI
# refer to the faq.md for more details
```