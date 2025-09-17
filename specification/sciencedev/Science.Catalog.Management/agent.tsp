import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Science")
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("Agent tracked resource")
model Agent is TrackedResource<AgentProperties> {
  ...ResourceNameParameter<Agent>;
}

@doc("Agent properties")
model AgentProperties {
  ...CatalogArtifactBaseProperties;

  @doc("The provisioning state of the AI agent.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Agents {
  get is ArmResourceRead<Agent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Agent>;
  update is ArmResourcePatchAsync<
    Agent,
    {
      description: string;
    }
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Agent>;
  listByResourceGroup is ArmResourceListByParent<Agent>;
  listBySubscription is ArmListBySubscription<Agent>;
}
