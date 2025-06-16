****# Azure Discovery - Swagger/OpenAPI spec dev guide

## Overview

The Azure Discovery API specification is defined using [Azure TypeSpec](https://azure.github.io/typespec-azure/docs/intro) which compiles to [OpenAPI/Swagger](https://swagger.io/specification/) JSON.
We have scripts to merge changes from `RPSaaSDev` to `RPSaaSMaster` and auto-generate `armclient` testing documentation and associated payloads.

## GIT repos

- Development (Private RP): [RPSaaSDev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSDev) > [specifications/discoverydev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSDev/specification/discoverydev)
  - RPSaaSDev > `specification/discoverydev` directory won't exist until [this PR](https://github.com/Azure/azure-rest-api-specs-pr/pull/19947/) is merged.
- Production: [RPSaaSMaster](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster) > [specifications/discoverydev](https://github.com/Azure/azure-rest-api-specs-pr/tree/RPSaaSMaster/specification/discovery)
  - RPSaaSMaster > `specification/discovery` directory won't exist until a PR is merged to create it (by merging related changes from RPSaaSDev).

## Directory structure

### OpenAPI spec component source code (TypeSpec)

Azure Discovery consists of a number of components maintained by different subteams. Each team is responsible for one or more packages within `specification/discoverydev`. The packages include:

- **Bookshelf**
  - Control plane: `specification/discoverydev/Discovery.Bookshelf.Management`
  - Data plane: `specification/discoverydev/Discovery.Bookshelf`
- **Catalog**
  - Control plane: `specification/discoverydev/Discovery.Catalog.Management`
  - Data plane: `specification/discoverydev/Discovery.Catalog`
- **Supercomputer**
  - Control plane: `specification/discoverydev/Discovery.Supercomputer.Management`
- **Workspace**
  - Control plane: `specification/discoverydev/Discovery.Workspace.Management`
  - Data plane: `specification/discoverydev/Discovery.Workspace`

This directory structure enables the subteam for each Azure Discovery API package to manage their own TypeSpec definition and API versions and minimize conflicts with other subteams.

### API examples

The TypeSpec compiler automatically processes examples in the `examples-dir` within `tspconfig.yaml`.

- Unfortunately, there is just one examples directory for control plane rather than one per package.
- The team for each component is responsible for creating examples within `Discovery.Management/examples/${api-version}`.
- We use `oav` to auto-generate examples from Swagger JSON.
- The file name must match the associated `operationId` within `discoverydev.json`.

### Shared TypeSpec code

All components will share a single API versions enumeration. Optionally components may share other common types such as `ProvisioningState`. This shared code will be maintained in `specification/discoverydev/Discovery.Management.Shared` from where it can be imported by the components.

### main.tsp

The entry point for configuring all control plane components is `specification/discoverydev/Discovery.Management/main.tsp`. To minimize merge conflicts between subteams when adding new resource types or renaming/reorganizing `tsp` files, each component will contain a file named `all.tsp` which will import all `tsp` files needed. Thus `main.tsp` will contain one line per component as follows:

```
import "../Discovery.Bookshelf.Management/all.tsp";
import "../Discovery.Catalog.Management/all.tsp";
import "../Discovery.Supercomputer.Management/all.tsp";
import "../Discovery.Workspace.Management/all.tsp";
```

### Generated

Compiling the TypeSpec source will generate content under the following directories:

- Control plane: `specification/discoverydev/resource-manager/Private.Discovery`
- Data plane: `specification/discoverydev/data-plane/Private.Discovery.{component}`

## Namespace(s)

### Azure Discovery components

Although each component subteam will maintain their TypeSpec and examples in a dedicated component-level package, all components will share a common namespace, `Microsoft.Discovery`. If a package (directory name) contains `.Management`, it is for the ARM control plane. If not, it's data plane.

### Prod vs Dev

Private RP (PRP) namespaces should start with `Private.` and production namespaces should stat with `Azure.`. To avoid the need to manually edit files when merging PRP changes to Prod, a converter is used to transform the PRP namespace. This is accomplished by importing `namespace-prp.tsp` in `main.tsp` for PRP but stripping this import from Prod.

```
namespace Private {
  @@armProviderNamespace(Microsoft.Discovery,
    "Private.Discovery"
  );
}
```

## Control Plane vs Data Plane

All requests for control plane operations are sent to the Azure Resource Manager URL. That URL varies by the Azure environment. Resources created using control plane APIs are considered ARM resources. Requests for data plane operations are sent to an endpoint that's specific to your instance. [Here](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/control-plane-and-data-plane) are the related docs. Read [here](https://eng.ms/docs/products/arm/rbac/authorization/data-plane) for Management plane vs Data plane RBAC.

## Fetching a branch from another fork

If you need to fetch a branch form a coworker's fork:

- `git remote add <coworker-username> https://github.com/<coworker-username>/azure-rest-api-specs-pr.git`
- `git fetch <coworker-username> <coworker-branch>`

## Initial setup

1. **Fork** (_don't clone_) ARM Swagger repo: [azure-rest-api-specs-pr](https://github.com/Azure/azure-rest-api-specs-pr)
   - `git remote add upstream https://github.com/Azure/azure-rest-api-specs-pr.git`
2. Create two local clones of your Swagger fork repo: One for `RPSaaSDev` another for `RPSaaSMaster`
   - The Swagger repo has `800k+` objects and more than `275MiB` of data, so it's very resource intensive to swap between `RPSaaSDev` and `RPSaaSMaster`. I strongly recommend cloning each into different directories instead of swapping `50k+` files each time you need to change between PRP and Prod.

In steps below, I refer to my current local Swagger repo copies:

1. **PRP repo base** for `RPSaaSDev` and _creating_ related branches.
2. **Prod repo base**: for `RPSaaSMaster` and _creating_ related branches.

## High level concept for update the API spec

Merging into `RPSaaSMaster` requires a more extensive ARM review which can take some time to reach the top of their queue.

Rather than doing an `RPSaaSMaster` PR for every `RPSaaSDev` PR, we may have a number of `RPSaaSDev` PRs merged and tested in PRP over the course of one or more sprints.
The cumulative changes of all dev PRs that have not been merged to prod, form a single RPSaaSMaster PR which acts as a feature set/release candidate.
This enables fully testing the release candidate in the same configuration for both Private RP and Prod (rather than merging individual features to Prod out of order which are likely to not have been tested in that exact configuration).

[//]: # "Note: Scripts run via `deno task` are defined in `Deployment/deno.jsonc` dir of `discovery-rp-infrastructure` and can be run from any directory within `Deployment`."

## Updating RPSaaSDev (PrivateRP)

1. Open GitBash shell (Windows) or [Oh My Zsh](https://ohmyz.sh/) (Recommended for Mac)
2. _From your PRP repo base_: `git checkout RPSaaSDev`
3. Sync with upstream: `git pull upstream RPSaaSDev --rebase -X theirs`
4. Create PRP PR branch: `git checkout -b <your-prp-pr-branch>`
5. Make changes to `*.tsp` files for resource types you wish to change.
6. Compile your `*.tsp` and re-generate examples:
   - _Control plane:_ `node specification/discoverydev/scripts/makeExamples--ControlPlane.mjs`
   - _Bookshelf data plane:_ `node specification/discoverydev/scripts/makeExamples--Bookshelf.mjs`
   - _Catalog data plane:_ `node specification/discoverydev/scripts/makeExamples--Catalog.mjs`
   - _Workspace data plane:_ `node specification/discoverydev/scripts/makeExamples--Workspace.mjs`
7. Run cleanup script: `node specification/discoverydev/scripts/cleanup-all.mjs`
8. Run validate script: `node specification/discoverydev/scripts/validate-all.mjs`
9. `git add specification/discoverydev`
10. `git commit`
11. Re-run validate script: `node specification/discoverydev/scripts/validate-all.mjs` (because `tsv` reformats files)
12. `git add specification/discoverydev`
13. `git commit`
14. When finished: `git push --set-upstream origin <your-prp-pr-branch>`

**IMPORTANT!**

- PR authors: Do not address ARM reviewer feedback and immediately merge to `RPSaaSMAster`! All changes should first be made in `RPSaaSDev` and re-tested before merging to `RPSaaSMaster`.
- PR reviewers: Do not approve `RPSaaSMaster` changes until tested in `RPSaaSDev`.
