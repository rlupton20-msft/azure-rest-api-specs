## AZ

These settings apply only when `--az` is specified on the command line.

For new Resource Provider. It is highly recommended to onboard Azure CLI extensions. There's no differences in terms of customer usage. 

``` yaml $(az) && $(target-mode) != 'core'
az:
    extensions: playfab
    namespace: azure.mgmt.playfab
    package-name: azure-mgmt-playfab
az-output-folder: $(azure-cli-extension-folder)/src/playfab
python-sdk-output-folder: "$(az-output-folder)/azext_playfab/vendored_sdks/playfab"
```

```yaml $(az)
directive:
    - where:
          group: playfab segment
          hidden: true
      set:
          group: playfab title segment
    - where:
          group: playfab playeraccountpool
      set:
          group: playfab player-account-pool
    - where:
          group: playfab titledataset
      set:
          group: playfab title title-data-set
    - where:
          group: playfab titleinternaldataset
      set:
          group: playfab title title-internal-data-set

cli:
    cli-directive:
    - where:
        group: Titles
        param: playerAccountPoolId
      alias:
        - player-account-pool-id
        - p
    - where:
        group: Titles
        op: CreateOrUpdate#Create|Update
        param: type
      name: assign-identity
    - where:
        type: Title
        prop: settings
      json: true
    - where:
        type: TitleDataSet|TitleInternalDataSet
        prop: keyValuePairs
      json: true
```
