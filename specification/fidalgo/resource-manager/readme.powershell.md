## Powershell

These settings only apply when `--powershell` is specified on the command line.

```yaml $(powershell)
output-folder: ../../../PowerShell/$(tag)/
module-name: Fidalgo
clear-output-folder: true
azure: true
azure-arm: true
prefix: AzDtc
sanitize-names: false
```

```yaml $(internalSdk)
directive:
  - from: fidalgo.json
    where: $.host
    transform: return "api-dogfood.resources.windows-int.net"
    reason: Generated Powershell uses a hard-coded url. To hit Dogfood we manipulate it here.
```