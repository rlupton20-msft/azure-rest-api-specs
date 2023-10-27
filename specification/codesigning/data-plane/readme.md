# Code Signing

> see https://aka.ms/autorest

This is the AutoRest configuration file for Code Signing service.

## Getting Started

To build the SDKs for Connected Cluster API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`



## Configuration

### Basic Information

These are the global settings for the Code Signing API.

``` yaml
openapi-type: data-plane
tag: package-2020-12-14-preview
```


### Tag: package-2020-01-14-preview

These settings apply only when `--tag=tag: package-2020-12-14-preview` is specified on the command line.

```yaml $(tag) == 'package-2020-12-14-preview'
input-file:
- Microsoft.CodeSigning/preview/2020-12-14-preview/codeSignAccount.json
```

---




