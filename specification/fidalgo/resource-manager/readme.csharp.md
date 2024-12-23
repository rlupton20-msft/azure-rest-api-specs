## C

These settings apply only when `--csharp` is specified on the command line.
Please also specify `--csharp-sdks-folder=<path to "SDKs" directory of your azure-sdk-for-net clone>`.

```yaml $(csharp)
csharp:
  azure-arm: true
  license-header: MICROSOFT_MIT_NO_VERSION
  clear-output-folder: true
  client-side-validation: false

payload-flattening-threshold: 2
namespace: "Microsoft.Azure.Management.Fidalgo"
output-folder: "$(csharp-sdks-folder)/Management/src/generated"
```

```yaml $(internalSdk)
directive:
  - from: swagger-document
    where: "$.definitions.IdentityProperties.properties.*"
    transform: >-
      $["readOnly"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.UserAssignedIdentity.properties.*"
    transform: >-
      $["readOnly"] = false;
      return $;

  - from: swagger-document
    where: "$.parameters.SubscriptionIdParameter"
    transform: >-
      $["x-ms-parameter-location"] = "method";
      return $;

  - from: swagger-document
    where: "$.definitions.TemplateSourceProperties.properties.*"
    transform: >-
      $["readOnly"] = false;
      return $;

  - from: swagger-document
    where: "$.definitions.*.properties.properties"
    transform: >-
      $["x-ms-client-flatten"] = false;
      return $;

  # The following enable OData filter in the Internal CSharp SDK. RPaaS only supports $filter parameter for calls made from UserRP (not customer), so they are not in the spec.
  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/providers/Microsoft.Fidalgo/devcenters'].get"
    transform: >-
      $.parameters.push({"$ref": "#/parameters/FilterParameter"});
      $["x-ms-odata"] = "#/definitions/DevCenter";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/DevCenter";
      return $;
  
  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/providers/Microsoft.Fidalgo/projects'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/Project";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/projects'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/Project";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/projects/{projectName}/environments'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/Environment";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/projects/{projectName}/catalogItems'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/CatalogItem";
      return $;
  
  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters/{devCenterName}/catalogs'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/Catalog";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters/{devCenterName}/catalogs/{catalogName}/items'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/CatalogItem";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters/{devCenterName}/mappings'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/Mapping";
      return $;

  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters/{devCenterName}/environmentTypes'].get"
    transform: >-
      $.parameters.push({"name": "$filter", "in": "query", "description": "The filter to apply to the operation. Example: '$filter=contains(name,'myName')", "type": "string", "required": false, "x-ms-parameter-location": "method"});
      $["x-ms-odata"] = "#/definitions/EnvironmentType";
      return $;
  # end OData filter directives
      
  # This directive adds the 200 status code for Catalog Update, which our client can receive but end users cannot
  - from: fidalgo.json
    where: "$.paths['/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Fidalgo/devcenters/{devCenterName}/catalogs/{catalogName}'].patch.responses"
    transform: >-
      $["200"] = {};
      $["200"]["description"] = "Succeeded";
      $["200"]["schema"] = {};
      $["200"]["schema"]["$ref"] = "#/definitions/Catalog";
      return $;

  # This directive makes our internal sdk correctly expect PUT operations from our user RP to be short running
  - from: swagger-document
    where: "$.paths.*.put"
    transform: >-
      $["x-ms-long-running-operation"] = false;
      $["x-ms-long-running-operation-options"] = undefined;
      return $;

  # This directive makes our internal sdk correctly expect PATCH operations from our user RP to be short running
  - from: swagger-document
    where: "$.paths.*.patch"
    transform: >-
      $["x-ms-long-running-operation"] = false;
      $["x-ms-long-running-operation-options"] = undefined;
      return $;
```