import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Workflow tracked resource")
model Workflow is TrackedResource<WorkflowProperties> {
  ...ResourceNameParameter<Workflow>;
}
/** Workflow tracked resource list response item */
model WorkflowListItem is TrackedResource<WorkflowListItemProperties> {
  ...ResourceNameParameter<Workflow>;
}

model WorkflowListResult is ResourceListResult<WorkflowListItem>;

@doc("Discovery Workflow list item properties")
model WorkflowListItemProperties {
  ...DiscoveryResourceProperties;
}

@doc("Discovery Workflow properties")
model WorkflowProperties {
  ...WorkflowListItemProperties;
  ...WithDefinitionContent;
}

@armResourceOperations
interface Workflows
  extends DiscoveryResource<Workflow, WorkflowProperties, WorkflowListResult> {}
