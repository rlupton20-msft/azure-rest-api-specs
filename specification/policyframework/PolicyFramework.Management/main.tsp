import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

/** Microsoft.PolicyFramework Resource Provider management API. */
@armProviderNamespace
@service({
  title: "Microsoft.PolicyFramework Resource Provider Management Service",
})
@versioned(Versions)
namespace Microsoft.PolicyFramework;

interface Operations extends Azure.ResourceManager.Operations {}

/** PolicyFramework RP API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

/**
 * The evaluation engine type definition
 */
@doc("The evaluation engine properties.")
model EvaluationEngineProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: ProvisioningState;
  // complete later with sample properties
}

@doc("The evaluation engine")
model EvaluationEngine is TrackedResource<EvaluationEngineProperties> {
  @key("evaluationEngineName")
  @segment("evaluationEngines")
  @visibility("readonly")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the evaluation engine.")
  name: string;
}

/**
 * The evaluation engine assignment type definition
 */
@doc("The evaluation engine assignment properties.")
model EvaluationEngineAssignmentProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The version of the evaluation engine assignment.")
  version: string;
  // complete later with sample properties
}

@doc("The evaluation engine assignment")
@parentResource(EvaluationEngine)
model EvaluationEngineAssignment
  is ProxyResource<EvaluationEngineAssignmentProperties> {
  @key("assignmentName")
  @segment("evaluationEngineAssignments")
  @visibility("readonly")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the evaluation engine assignment.")
  name: string;
}

/**
 * The evaluation engine policy type definition
 */
@doc("The evaluation engine policy definition properties.")
model EvaluationEnginePolicyDefinitionProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The version of the evaluation engine policy definition.")
  version: string;
  // complete later with sample properties
}

@doc("The evaluation engine policy definition")
@parentResource(EvaluationEngine)
model EvaluationEnginePolicyDefinition
  is ProxyResource<EvaluationEnginePolicyDefinitionProperties> {
  @key("policyName")
  @segment("evaluationEnginePolicyDefinitions")
  @visibility("read")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the evaluation engine policy definition.")
  name: string;
}

@lroStatus
@doc("The provisioning state of the last accepted operation")
union ProvisioningState {
  ResourceProvisioningState, // include standard provisioning states

  @doc("Resource is creating")
  Creating: "Creating",

  @doc("Resource is updating")
  Updating: "Updating",

  @doc("Resource is deleting")
  Deleting: "Deleting",

  @doc("Resource succeeded")
  Succeeded: "Succeeded",

  @doc("Resource failed")
  Failed: "Failed",
}

@armResourceOperations
interface EvaluationEngineOperations {
  get is ArmResourceRead<EvaluationEngine>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EvaluationEngine>;
  update is ArmResourcePatchAsync<EvaluationEngine, EvaluationEngineProperties>;
  delete is ArmResourceDeleteSync<EvaluationEngine>;
  listByResourceGroup is ArmResourceListByParent<EvaluationEngine>;
  listBySubscription is ArmListBySubscription<EvaluationEngine>;
}

@armResourceOperations
interface EvaluationEngineAssignmentOperations {
  get is ArmResourceRead<EvaluationEngineAssignment>;
  create is ArmResourceCreateOrReplaceSync<EvaluationEngineAssignment>;
  update is ArmResourcePatchSync<
    EvaluationEngineAssignment,
    EvaluationEngineAssignmentProperties
  >;
  delete is ArmResourceDeleteSync<EvaluationEngineAssignment>;
  listByParent is ArmResourceListByParent<EvaluationEngineAssignment>;
}

@armResourceOperations
interface PolicyDefinitionOperations {
  get is ArmResourceRead<EvaluationEnginePolicyDefinition>;
  create is ArmResourceCreateOrReplaceSync<EvaluationEnginePolicyDefinition>;
  update is ArmResourcePatchSync<
    EvaluationEnginePolicyDefinition,
    EvaluationEnginePolicyDefinitionProperties
  >;
  delete is ArmResourceDeleteSync<EvaluationEnginePolicyDefinition>;
  listByParent is ArmResourceListByParent<EvaluationEnginePolicyDefinition>;
}
