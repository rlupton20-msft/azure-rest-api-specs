# devops

> see https://aka.ms/autorest

This is the AutoRest configuration file for devops.

```yaml
openapi-subtype: rpaas
```

### Tag: package-2020-10-01-preview

These settings apply only when `--tag=package-2020-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-10-01-preview'
input-file:
  - Microsoft.DevOps/preview/2020-10-01-preview/devops.json
```

### Tag: package-2020-12-01-preview

These settings apply only when `--tag=package-2020-12-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-12-01-preview'
input-file:
  - Microsoft.DevOps/preview/2020-12-01-preview/devops.json
```