## Python

These settings apply only when `--python` is specified on the command line.
Please also specify `--python-sdks-folder=<path to the root directory of your azure-sdk-for-python clone>`.
Use `--python-mode=update` if you already have a setup.py and just want to update the code itself.

``` yaml
python-mode: create
azure-arm: true
license-header: MICROSOFT_MIT_NO_VERSION
payload-flattening-threshold: 2
package-name: azure-codesigning
clear-output-folder: true
no-namespace-folders: true
```

### Tag: package-2020-01-14-preview

These settings apply only when `--tag=package-2020-12-14-preview` is specified on the command line.

``` yaml $(tag) == 'package-2020-12-14-preview'
namespace: azure.codesigning.v2020-12-14-preview
output-folder: $(python-sdks-folder)/codesigning/azure-codesigning/azure/codesigning/2020-12-14-preview
```
