## Ruby

These settings apply only when `--ruby` is specified on the command line.

```yaml
package-name: azure_mgmt_easystart
package-version: 2020-08-27-privatepreview
azure-arm: true
```

### Tag: package-2020-08-27-privatepreview and ruby

These settings apply only when `--tag=package-2020-08-27-privatepreview --ruby` is specified on the command line.
Please also specify `--ruby-sdks-folder=<path to the root directory of your azure-sdk-for-ruby clone>`.

```yaml $(tag) == 'package-2020-08-27-privatepreview' && $(ruby)
namespace: Microsoft.EasyStartTest
output-folder: $(ruby-sdks-folder)/easystart
```
