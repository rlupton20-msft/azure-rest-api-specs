import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../Discovery.Management.Shared/all.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Tool tracked resource")
model Tool is TrackedResource<ToolProperties> {
  ...ResourceNameParameter<Tool>;
}

/** Tool tracked resource list response item */
model ToolListItem is TrackedResource<ToolListItemProperties> {
  ...ResourceNameParameter<Tool>;
}

model ToolListResult is ResourceListResult<ToolListItem>;

@doc("Discovery Tool list item properties")
model ToolListItemProperties {
  ...DiscoveryResourceProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("Environment variables to make available")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  environmentVariables?: Record<string>;
}

@doc("Discovery Tool properties")
model ToolProperties {
  ...ToolListItemProperties;
  ...WithDefinitionContent;
}

@armResourceOperations
interface Tools
  extends DiscoveryResource<Tool, ToolProperties, ToolListResult> {}
