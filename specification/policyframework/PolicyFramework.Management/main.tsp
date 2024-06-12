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
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the evaluation engine policy definition.")
  name: string;
}

/**
 * Provisioning State information
 */
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

/**
 * Evaluation POST request and response
 */
@doc("The evaluation action request")
model EvaluationActionRequest {
  @doc("The evaluation type")
  type: string;

  @doc("The location of the evaluation")
  location: string;

  @doc("The evaluation property")
  property: string;
}

@doc("The evaluation action response")
model EvaluationActionResponse {
  @doc("The evaluation id")
  id: string;

  @doc("The evaluation scope")
  scope: string;

  @doc("the evaluation parameters")
  parameters: string; // null TBD

  @doc("The evaulation policy definition id")
  policyDefinitionId: string; // null TBD

  @doc("The evaluation applicability rule")
  applicabilityRule: string;

  @doc("The evaluation effect rule")
  effectRule: string;

  @doc("The evaluation effect")
  effect: string;

  @doc("The evaluation effect configuration")
  effectConfiguration: string; // null TBD
}

/**
 * Evaluate Applicability POST request and response
 */
@doc("The applicability action request")
model ApplicabilityActionRequest {
  @doc("The applicability type")
  type: string;

  @doc("The applicability property")
  property: string;
}

@doc("The applicability action response")
model ApplicabilityActionResponse {
  @doc("The applicability id")
  id: string;

  @doc("The applicability scope")
  scope: string;

  @doc("The applicability parameters")
  parameters: string; // null TBD

  @doc("The applicability policy definition id")
  policyDefinitionId: string; // null TDB

  @doc("The applicability rule")
  applicabilityRule: string;

  @doc("The applicability effect rule")
  effectRule: string;

  @doc("The applicability effect")
  effect: string;

  @doc("The applicability effect configuration")
  effectConfiguration: string; // null TBD
}

@armResourceOperations
interface EvaluationEngineOperations {
  get is ArmResourceRead<EvaluationEngine>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EvaluationEngine>;
  update is ArmResourcePatchAsync<EvaluationEngine, EvaluationEngineProperties>;
  delete is ArmResourceDeleteSync<EvaluationEngine>;
  listByResourceGroup is ArmResourceListByParent<EvaluationEngine>;
  listBySubscription is ArmListBySubscription<EvaluationEngine>;
  evaluate is ArmResourceActionAsync<
    EvaluationEngine,
    EvaluationActionRequest,
    EvaluationActionResponse
  >;
  applicability is ArmResourceActionAsync<
    EvaluationEngine,
    ApplicabilityActionRequest,
    ApplicabilityActionResponse
  >;
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
