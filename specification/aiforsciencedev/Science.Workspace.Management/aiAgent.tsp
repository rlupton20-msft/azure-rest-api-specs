import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";

import "./project.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.Science")
@versioned(Microsoft.Science.Versions)
namespace Microsoft.Science;

@doc("AiAgent tracked resource")
model AiAgent is TrackedResource<AiAgentProperties> {
  ...ResourceNameParameter<AiAgent>;
}

@doc("AiAgent properties")
model AiAgentProperties {
  @doc("The description of the AI agent.")
  @visibility("read", "create", "update")
  description: string;

  @doc("The ID of the catalog agent.")
  @visibility("read", "create", "update")
  catalogAgentReference: Artifact;

  @doc("The provisioning state of the AI agent.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AiAgents {
  get is ArmResourceRead<AiAgent>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AiAgent>;
  update is ArmResourcePatchSync<
    AiAgent,
    {
      description: string;
    }
  >;
  delete is ArmResourceDeleteWithoutOkAsync<AiAgent>;
  listByResourceGroup is ArmResourceListByParent<AiAgent>;
  listBySubscription is ArmListBySubscription<AiAgent>;
}
