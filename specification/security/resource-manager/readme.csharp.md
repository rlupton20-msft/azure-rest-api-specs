## C#

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

## Common C# settings

``` yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  payload-flattening-threshold: 2
  clear-output-folder: true
```

``` yaml $(csharp) && !$(multiapi) && !$(profile)
  namespace: Microsoft.Azure.Management.Security
  output-folder: $(csharp-sdks-folder)/security/Microsoft.Azure.Management.Security/src/Generated
```