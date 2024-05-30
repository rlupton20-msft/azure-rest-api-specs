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

/** PolicyFramework RP API versions. */
enum Versions {
  /** 2024-06-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_06_01_preview: "2024-06-01-preview",
}

/**
 * The evaluation engine type definition (inlcude name and properties of the evaluaiton engine)
 */
@doc("The evaluation engine properties.")
model EvaluationEngineProperties {
  name: string;
  // complete later with sample properties
}

@doc("The evaluation engine")
model EvaluationEngine is TrackedResource<EvaluationEngineProperties> {
  @key("engineName")
  @segment("evaluationEngines")
  @visibility("read")
  @path
  name: string;
}

/**
 * The evaluation engine assignment type definition
 */
@doc("The evaluation engine assignment properties.")
model EvaluationEngineAssignmentProperties {
  name: string;
  // complete later with sample properties
}

@doc("The evaluation engine assignment")
@parentResource(EvaluationEngine)
model EvaluationEngineAssignment
  is TrackedResource<EvaluationEngineAssignmentProperties> {
  @key("assignmentName")
  @segment("policyAssignments")
  @visibility("read")
  @path
  name: string;

  type: "Microsoft.PolicyFramework/evaluationEngines/Assignments";
}

/**
 * The evaluation engine policy type definition
 */
@doc("The evaluation engine policy definition properties.")
model PolicyDefinitionProperties {
  name: string;
  // complete later with sample properties
}

@doc("The evaluation engine policy definition")
@parentResource(EvaluationEngine)
model PolicyDefinition is TrackedResource<PolicyDefinitionProperties> {
  @key("policyName")
  @segment("policyDefinitions")
  @visibility("read")
  @path
  name: string;

  type: "Microsoft.PolicyFramework/evaluationEngines/Definitions";
}

@armResourceOperations
interface EvaluationEngineOperations {
  get is ArmResourceRead<EvaluationEngine>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EvaluationEngine>;
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
  get is ArmResourceRead<PolicyDefinition>;
  create is ArmResourceCreateOrReplaceSync<PolicyDefinition>;
  update is ArmResourcePatchSync<PolicyDefinition, PolicyDefinitionProperties>;
  delete is ArmResourceDeleteSync<PolicyDefinition>;
  listByParent is ArmResourceListByParent<PolicyDefinition>;
}
