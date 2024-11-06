# AI for Science - Catalog API spec dev guide

## Overview
The AI for Science Catalog API specification is defined using [Azure TypeSpec](https://azure.github.io/typespec-azure/docs/intro) which compiles to [OpenAPI/Swagger](https://swagger.io/specification/) JSON. We use Private RP for development using the `azure-rest-api-specs-pr` [RPSaaSDev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSDev) branch. The production branch is [RPSaaSMaster](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster). We have scripts to assist with merging changes from `RPSaaSDev` to `RPSaaSMaster`.

## Directory structure
### Component source code
AI for Science consists of a number of components maintained by different subteams. Each team is responsible for one or more packages within `specification/aiforscience`. The packages include:
- __Catalog__
  - Control plane: `specification/aiforscience/Private.AiForScience.Catalog.Management`
  - Data plane: `specification/aiforscience/Private.AiForScience.Catalog` (may or may not be used)
- __Copilot__
  - Control plane: `specification/aiforscience/Private.AiForScience.Copilot.Management`
- __Supercomputer__
  - Control plane: `specification/aiforscience/Private.AiForScience.Supercomputer.Management`

This directory structure enables the subteam for each AI for Science Catalog API package to manage their own TypeSpec definition and API versions and minimize conflicts with other subteams.

## Examples
The TypeSpec compiler automatically processes examples in the `examples-dir` within `tspconfig.yaml`. 
Unfortunately, there is just one examples directory rather than one per package. 
The team for each component is responsible for creating examples within `Private.AiForScience.Management/examples/${api-version}`. 
The file name must match the associated `operationId` within `aiforscience.json`.

### Shared source code
All components will share a single API versions enumeration. Optionally components may share other common types such as `ProvisioningState`. This shared code will be maintained in `specification/aiforscience/Private.AiForScience.Common` from where it can be imported by the components.


### main.tsp
The entry point for configuring all components is `specification/aiforscience/Private.AiForScience.Management/main.tsp`. To minimize merge conflicts between subteams when adding new resource types or renaming/reorganizing `tsp` files, each component will contain a file named `all.tsp` which will import all `tsp` files needed. Thus `main.tsp` will contain one line per component as follows:
```
import "../Private.AiForScience.Catalog.Management/all.tsp";
import "../Private.AiForScience.Copilot.Management/all.tsp";
```

### Generated
Compiling the TypeSpec source will generate content under the following directories:
- Control plane: `specification/aiforscience/resource-manager/Private.AiForScience`
- Data plane: `specification/aiforscience/data-plane/Private.AiForScience`

Although the source code for each component is maintained in its own package, a single generated API spec/Swagger JSON file will document the API for all components.

## How to build
1. Change directories to the root of the `azure-rest-api-specs-pr` repo.
2. Install dependencies: `npm ci`
3. Compile TypeSPec to generate OpenAPI: `npx tsp compile specification/aiforscience/Private.AiForScience.Management`
4. Review generated control plane API output within `specification/aiforscience/resource-manager`
5. `git add` and `git commit` changes.
6. Validate: `npx tsv specification/aiforscience/Private.AiForScience.Management`
   -  Validation also performs formatting which may cause validation to fail due to un-commited files. Repeat above to commit these.
   - Run validate again.
7. Push changes to your remote Git branch: 
   - 1st push to branch: `git push --set-upstream origin <your-pr-branch-name>`
   - Follow-on push: `git push`

## Namespace(s)

### AI for Science components
Although each component subteam will maintain their TypeSpec and examples in a dedicated component-level package, all components will share a common namespace, `Microsoft.AiForScience`.

### Prod vs Dev
Private RP (PRP) namespaces should start with `Private.` and production namespaces should stat with `Microsoft.`. To avoid the need to manually edit files when merging PRP changes to Prod, a converter is used to transform the PRP namespace. This is accomplished by importing `namespace-prp.tsp` in `main.tsp` for PRP but stripping this import from Prod.
```
namespace Private {
  @@armProviderNamespace(Microsoft.AiForScience,
    "Private.AiForScience"
  );
}
```

## Quick-start templates
One way to create a new AI for Science Catalog package is to use one of the Azure provided [templates](https://azure.github.io/typespec-azure/docs/getstarted/createproject).
1. Create the directory (e.g. `specification/aiforscience/Private.AiForScience.Supercomputer.Management`)
2. `cd` to the directory you crated.
2. `tsp init https://aka.ms/typespec/azure-init`
3. Even though you use `Private.*` for the directory name, be sure to use `Microsoft.*` for the project and namespace names.
4. Rename `employee.tsp` to match the resource type name you want to model.
5. Be sure to update `main.tsp` and change `@versioned(Microsoft.Contoso.Versions)` to your namespace.

## Control Plane vs Data Plane
All requests for control plane operations are sent to the Azure Resource Manager URL. That URL varies by the Azure environment. Resources created using control plane APIs are considered ARM resources. Requests for data plane operations are sent to an endpoint that's specific to your instance. [Here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) are the related docs. Read [here](https://eng.ms/docs/products/arm/rbac/authorization/data-plane) for Management plane vs Data plane RBAC.
