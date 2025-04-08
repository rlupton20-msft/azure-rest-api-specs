# Microsoft Science - Swagger/OpenAPI spec dev guide
## Overview
The Microsoft Science API specification is defined using [Azure TypeSpec](https://azure.github.io/typespec-azure/docs/intro) which compiles to [OpenAPI/Swagger](https://swagger.io/specification/) JSON.
We have scripts to merge changes from `RPSaaSDev` to `RPSaaSMaster` and auto-generate `armclient` testing documentation and associated payloads.

Please follow the Science team's Swagger [development process](https://dev.azure.com/msazuredev/AIforSciencePlatform/_git/science-rp-infrastructure?path=/documentation/swagger/api-spec-update-process.md&_a=preview) for updating this API spec.

## GIT repos

- Development (Private RP): [RPSaaSDev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSDev) > [specifications/sciencedev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSDev/specification/sciencedev)
    - RPSaaSDev > `specification/sciencedev` directory won't exist until [this PR](https://github.com/Azure/azure-rest-api-specs-pr/pull/19947/) is merged.
- Production: [RPSaaSMaster](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster) > [specifications/sciencedev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster/specification/sciencedev)
    - RPSaaSMaster > `specification/science` directory won't exist until a PR is merged to create it (by merging related Science changes from RPSaaSDev).

## Directory structure
### OpenAPI spec component source code (TypeSpec)
Microsoft Science consists of a number of components maintained by different subteams. Each team is responsible for one or more packages within `specification/sciencedev`. The packages include:
- __Bookshelf__
    - Control plane: `specification/sciencedev/Science.Bookshelf.Management`
    - Data plane: `specification/sciencedev/Science.Bookshelf`
- __Catalog__
    - Control plane: `specification/sciencedev/Science.Catalog.Management`
    - Data plane: `specification/sciencedev/Science.Catalog` 
- __Supercomputer__
    - Control plane: `specification/sciencedev/Science.Supercomputer.Management`
- __Workspace__
    - Control plane: `specification/sciencedev/Science.Workspace.Management`
    - Data plane: `specification/sciencedev/Science.Workspace`

This directory structure enables the subteam for each Microsoft Science API package to manage their own TypeSpec definition and API versions and minimize conflicts with other subteams.

### API examples
The TypeSpec compiler automatically processes examples in the `examples-dir` within `tspconfig.yaml`.
- Unfortunately, there is just one examples directory for control plane rather than one per package.
- The team for each component is responsible for creating examples within `Science.Management/examples/${api-version}`. 
- We use `oav` to auto-generate examples from Swagger JSON.
- The file name must match the associated `operationId` within `sciencedev.json`.

### Shared TypeSpec code
All components will share a single API versions enumeration. Optionally components may share other common types such as `ProvisioningState`. This shared code will be maintained in `specification/sciencedev/Science.Management.Shared` from where it can be imported by the components.


### main.tsp
The entry point for configuring all control plane components is `specification/sciencedev/Science.Management/main.tsp`. To minimize merge conflicts between subteams when adding new resource types or renaming/reorganizing `tsp` files, each component will contain a file named `all.tsp` which will import all `tsp` files needed. Thus `main.tsp` will contain one line per component as follows:
```
import "../Science.Bookshelf.Management/all.tsp";
import "../Science.Catalog.Management/all.tsp";
import "../Science.Supercomputer.Management/all.tsp";
import "../Science.Workspace.Management/all.tsp";
```

### Generated
Compiling the TypeSpec source will generate content under the following directories:
- Control plane: `specification/sciencedev/resource-manager/Private.Science`
- Data plane: `specification/sciencedev/data-plane/Private.Science`

[//]: # (### Helper scripts)

[//]: # (Scripts &#40;deno tasks&#41; for merging Swagger and generating `armclient` testing docs are maintained in `science-rp-infrastructure/Deployment/Swagger`.)

## Namespace(s)

### Microsoft Science components
Although each component subteam will maintain their TypeSpec and examples in a dedicated component-level package, all components will share a common namespace, `Microsoft.Science`. If a package (directory name) contains `.Management`, it is for the ARM control plane. If not, it's data plane.

### Prod vs Dev
Private RP (PRP) namespaces should start with `Private.` and production namespaces should stat with `Microsoft.`. To avoid the need to manually edit files when merging PRP changes to Prod, a converter is used to transform the PRP namespace. This is accomplished by importing `namespace-prp.tsp` in `main.tsp` for PRP but stripping this import from Prod.
```
namespace Private {
  @@armProviderNamespace(Microsoft.Science,
    "Private.Science"
  );
}
```

[//]: # (In addition to this, `merge-swagger-to-prod` also replaces `Private.Science` documentation references to `Microsoft.Science`.)

## Control Plane vs Data Plane
All requests for control plane operations are sent to the Azure Resource Manager URL. That URL varies by the Azure environment. Resources created using control plane APIs are considered ARM resources. Requests for data plane operations are sent to an endpoint that's specific to your instance. [Here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) are the related docs. Read [here](https://eng.ms/docs/products/arm/rbac/authorization/data-plane) for Management plane vs Data plane RBAC.

## Fetching a branch from another fork
If you need to fetch a branch form a coworker's fork:
- `git remote add <coworker-username> https://github.com/<coworker-username>/azure-rest-api-specs-pr.git`
- `git fetch <coworker-username> <coworker-branch>`

## Initial setup

[//]: # (1. Install [Deno]&#40;https://docs.deno.com/runtime/manual/getting_started/installation/&#41;.)

[//]: # (2. Clone [science-rp-infrastructure]&#40;https://dev.azure.com/msazuredev/AIforSciencePlatform/_git/science-rp-infrastructure&#41;.)
1. **Fork** (*don't clone*) ARM Swagger repo: [azure-rest-api-specs-pr](https://github.com/Azure/azure-rest-api-specs-pr)
    - `git remote add upstream https://github.com/Azure/azure-rest-api-specs-pr.git`
1. Create two local clones of your Swagger fork repo: One for `RPSaaSDev`  another for `RPSaaSMaster`
    - The Swagger repo has `800k+` objects and more than `275MiB` of data, so it's very resource intensive to swap between `RPSaaSDev` and `RPSaaSMaster`. I strongly recommend cloning each into different directories instead of swapping `50k+` files each time you need to change between PRP and Prod.

In steps below, I refer to my current local Swagger repo copies:
1. **PRP repo base** for `RPSaaSDev` and *creating* related branches.
2. **Prod repo base**: for `RPSaaSMaster` and *creating* related branches.

[//]: # (3. Before using these scripts it's highly recommended that you create a `.env` file in your home directory similar to this:)

[//]: # (```)

[//]: # (# Directory path where you have cloned the Science RP Infrastructure git repo)

[//]: # (Science_RP_Infra_DIR="/Users/mick/code/JS/science-rp-infrastructure")

[//]: # ()
[//]: # (# Directory path where you have cloned your RPSaaSDev branch of azure-rest-api-specs-pr git repo)

[//]: # (AZURE_REST_API_SPECS_PR_RPSAASDEV_DIR="/Users/mick/code/JS/azure-rest-api-specs-pr")

[//]: # ()
[//]: # (# Directory path where you have cloned your RPSaaSMaster branch of azure-rest-api-specs-pr git repo)

[//]: # (AZURE_REST_API_SPECS_PR_RPSAASMASTER_DIR="/Users/mick/code/JS/azure-rest-api-specs-pr-rpsaasmaster")

[//]: # (```)

## High level concept for update the API spec
Merging into `RPSaaSMaster` requires a more extensive ARM review which can take some time to reach the top of their queue.

Rather than doing an `RPSaaSMaster` PR for every `RPSaaSDev` PR, we may have a number of `RPSaaSDev` PRs merged and tested in PRP over the course of one or more sprints.
The cumulative changes of all dev PRs that have not been merged to prod, form a single RPSaaSMaster PR which acts as a feature set/release candidate.
This enables fully testing the release candidate in the same configuration for both Private RP and Prod (rather than merging individual features to Prod out of order which are likely to not have been tested in that exact configuration).

[//]: # (Note: Scripts run via `deno task` are defined in `Deployment/deno.jsonc` dir of `science-rp-infrastructure` and can be run from any directory within `Deployment`.)

## Updating RPSaaSDev (PrivateRP)

1. Open GitBash shell (Windows) or [Oh My Zsh](https://ohmyz.sh/) (Recommended for Mac)
2. *From your PRP repo base*: `git checkout RPSaaSDev`
3. Sync with upstream: `git pull upstream RPSaaSDev --rebase -X theirs`
4. Create PRP PR branch: `git checkout -b <your-prp-pr-branch>`
5. Make changes to `*.tsp` files for resource types you wish to change.
6. Compile your `*.tsp` and re-generate examples:
   - *Control plane:* `node specification/sciencedev/scripts/makeExamples--ControlPlane.mjs`
   - *Bookshelf data plane:* `node specification/sciencedev/scripts/makeExamples--Bookshelf.mjs`
   - *Catalog data plane:* `node specification/sciencedev/scripts/makeExamples--Catalog.mjs`
   - *Workspace data plane:* `node specification/sciencedev/scripts/makeExamples--Workspace.mjs`
7. Run cleanup script: `node specification/sciencedev/scripts/cleanup-all.mjs`
8. Run validate script: `node specification/sciencedev/scripts/validate-all.mjs`
9. `git add specification/sciencedev`
10. `git commit`
11. Re-run validate script: `node specification/sciencedev/scripts/validate-all.mjs` (because `tsv` reformats files)
12. `git add specification/sciencedev`
13. `git commit`
14. When finished: `git push --set-upstream origin <your-prp-pr-branch>`

[//]: # (3. Update PRP `armclient` examples & documentation.)

[//]: # (    - From `Deployment` dir of `science-rp-infrastructure` repo: `deno task make-armclient-docs-prp`)

[//]: # (4. Create PRP `science-rp-infrastructure` PR.)

[//]: # (5. Update Prod TypeSpec & associated examples via `RPSaaSMaster` Swagger PR.)

[//]: # (    - *From your Prod repo base*: `git checkout RPSaaSMaster`)

[//]: # (    - Sync with upstream: `git pull upstream RPSaaSMaster --rebase -X theirs`)

[//]: # (    - Create Prod PR branch: `git checkout -b <your-prod-pr-branch>`)

[//]: # (    - Fetch PRP branch: `git fetch origin <your-prp-pr-branch>` &#40;or git fetch origin RPSaaSDev is merging from there&#41;)

[//]: # (    - Merge changes from dev branch to prod branch:)

[//]: # (        - `deno task merge-swagger-to-prod` &#40;to merge from RPSaaSDev&#41;)

[//]: # (        - `deno task merge-swagger-to-prod -b origin/<your-dev-branch>` &#40;to merge from your branch&#41;)

[//]: # (    - Review each file that changed: `git status`)

[//]: # (    - When finished: `git push --set-upstream origin <your-prod-pr-branch>`)

[//]: # (7. Update Prod `armclient` examples & documentation.)

[//]: # (    - `deno task make-armclient-docs-prod`)

[//]: # (8. Create Prod `science-rp-infrastructure` PR. You may wish to place this PR in draft so you can view and address any issues identified by the production pipeline as the checks in `RPsaSMater` vay significantly form those in `RPSaaSDev`.)

__IMPORTANT!__
- PR authors: Do not address ARM reviewer feedback and immediately merge to `RPSaaSMAster`! All changes should first be made in `RPSaaSDev` and re-tested before merging to `RPSaaSMaster`.
- PR reviewers: Do not approve `RPSaaSMaster` changes until tested in `RPSaaSDev`.





