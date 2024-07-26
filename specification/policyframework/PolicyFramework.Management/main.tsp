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
  // TODO: complete later with sample properties
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
 * The evaluation engine policy assignment type definition
 */
@doc("The evaluation engine policy assignment properties.")
model EvaluationEnginePolicyAssignmentProperties {
  @doc("Provisioning State")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The version of the evaluation engine policy assignment.")
  version: string;

  @doc("The scopes of the evaluation engine policy assignment.")
  scopes: string[];

  @doc("The notScopes of the evaluation engine policy assignment.")
  notScopes?: string[];

  @doc("The description of the evaluation engine policy assignment.")
  @pattern("^[a-zA-Z0-9 ]{3,250}$")
  description?: string;

  @doc("The metadata of the evaluation engine policy assignment.")
  metadata?: {};

  @doc("The corresponding policy definition id for the policy assignment.")
  policyDefinitionId: string;

  @doc("The parameters of the evaluation engine policy assignment.")
  parameters?: string;
}

@doc("The evaluation engine assignment")
@parentResource(EvaluationEngine)
model EvaluationEnginePolicyAssignment
  is ProxyResource<EvaluationEnginePolicyAssignmentProperties> {
  @key("policyAssignmentName")
  @segment("evaluationEnginePolicyAssignments")
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the evaluation engine policy assignment.")
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

  @doc("The description of the evaluation engine policy definition.")
  @pattern("^[a-zA-Z0-9 ]{3,250}$")
  description?: string;

  @doc("The parameters of the evaluation engine policy definition.")
  parameters?: string;

  @doc("The metadata of the evaluation engine policy definition.")
  metadata?: {};

  @doc("Set of 0+ conditions in specified language that returns boolean")
  applicabilityConditions?: string;

  @doc("Set of 1+ conditions in specified language that returns boolean")
  complianceConditions: string;

  @doc("Templatized effect following structure/syntax as defined in effect config of engine")
  effect?: {};
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
 * POST actions compliance result
 */
@doc("The result of the last accepted operation")
union ComplianceResult {
  @doc("The action succeeded")
  Compliant: "Compliant",

  @doc("The action failed")
  NonCompliant: "NonCompliant",

  @doc("The Unknown result")
  Unknown: "Unknown",

  string,
}
/**
 * POST actions applicability result
 */
@doc("The applicability result of the last accepted operation")
union ApplicabilityResult {
  @doc("The action succeeded")
  Applicable: "Applicable",

  @doc("The action failed")
  NotApplicable: "NotApplicable",

  @doc("The Unknown result")
  Unknown: "Unknown",

  string,
}

/**
 * POST actions effect
 *  retrieved from the Azure Policy definitions effect
 */
@doc("The policy definitions effect")
union PolicyDefinitionsEffect {
  @doc("The add to network group effect")
  AddToNetworkGroup: "addToNetworkGroup",

  @doc("The append effect")
  Append: "append",

  @doc("The audit effect")
  Audit: "audit",

  @doc("The audit if not exists effect")
  AuditIfNotExists: "auditIfNotExists",

  @doc("The deny effect")
  Deny: "deny",

  @doc("The deny action effect")
  DenyAction: "denyAction",

  @doc("The deploy if not exists effect")
  DeployIfNotExists: "deployIfNotExists",

  @doc("The disabled effect")
  Disabled: "disabled",

  @doc("The manual effect")
  Manual: "manual",

  @doc("The modify effect")
  Modify: "modify",

  @doc("The mutate effect")
  Mutate: "mutate",

  string,
}

/**
 * Evaluation POST request and response
 */
@doc("The evaluation action request")
model EvaluationActionRequest {
  @doc("The evaluation type")
  type: string;

  @doc("The location of the evaluation")
  @visibility("create", "read")
  location: string;

  @doc("The evaluation properties")
  requestProperties: string;

  @doc("The evaluation scope")
  scope: string;
}

@doc("The evaluation action response")
model EvaluationActionResponse is Azure.ResourceManager.Foundations.Resource {
  @doc("The evaluation scope")
  scope: string;

  @doc("the evaluation parameters")
  parameters?: string;

  @doc("The evaluation policy definition id")
  policyDefinitionId?: string;

  @doc("The evaluation applicability rule")
  applicabilityRule: string;

  @doc("The evaluation effect rule")
  effectRule: string;

  @doc("The evaluation effect")
  effect?: PolicyDefinitionsEffect;

  @doc("The evaluation effect configuration")
  effectConfiguration?: string;

  @doc("The evaluation result")
  result: ComplianceResult;
}

/**
 * Evaluate Applicability POST request and response
 */
@doc("The applicability action request")
model ApplicabilityActionRequest {
  @doc("The applicability type")
  type: string;

  @doc("The applicability properties")
  requestProperties: string;

  @doc("The applicability scope")
  scope: string;
}

@doc("The applicability action response")
model ApplicabilityActionResponse
  is Azure.ResourceManager.Foundations.Resource {
  @doc("The applicability scope")
  scope: string;

  @doc("The applicability parameters")
  parameters?: string;

  @doc("The applicability policy definition id")
  policyDefinitionId?: string;

  @doc("The applicability rule")
  applicabilityRule: string;

  @doc("The applicability effect rule")
  effectRule: string;

  @doc("The applicability effect")
  effect?: PolicyDefinitionsEffect;

  @doc("The applicability effect configuration")
  effectConfiguration?: string;

  @doc("The evaluation result")
  result: ApplicabilityResult;
}

/**
 * Transpile POST request and response
 */
@doc("The transpile action request")
model TranspileActionRequest {
  @doc("The transpile type")
  type: string;

  @doc("The transpile location")
  @visibility("create", "read")
  location: string;

  @doc("The transpile request scope")
  scope: string;
}

@doc("The transpile action response")
model TranspileActionResponse is Azure.ResourceManager.Foundations.Resource {
  @doc("The transpile scope")
  scope: string;

  @doc("The transpile parameters")
  parameters?: string;

  @doc("The transpile policy definition id")
  policyDefinitionId?: string;

  @doc("The transpile rule")
  applicabilityRule: string;

  @doc("The transpile effect rule")
  effectRule: string;

  @doc("The transpile effect")
  effect?: PolicyDefinitionsEffect;

  @doc("The transpile effect configuration")
  effectConfiguration?: string;

  @doc("The evaluation result")
  result: ApplicabilityResult;
}

// NOTE(chrostow): This is a template for resource list actions that return synchronously with no request body. This which will be added to the library at some point.
/**
 * Custom operations template for the evaluation engine actions - POST
 */
#suppress "@azure-tools/typespec-azure-core/documentation-required" "This is a template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "This is a template"
@extension("x-ms-long-running-operation", true)
@extension(
  "x-ms-long-running-operation-options",
  {
    `final-state-via`: "location",
  }
)
@autoRoute
@armResourceAction(TResource)
@post
op ArmResourceListActionAsync<
  TResource extends Azure.ResourceManager.Foundations.Resource,
  TRequest extends {},
  TResponse extends Azure.ResourceManager.Foundations.Resource,
  TBaseParameters = Azure.ResourceManager.Foundations.BaseParameters<TResource>
>(
  ...ResourceInstanceParameters<TResource, TBaseParameters>,

  @doc("The request body")
  @bodyRoot
  request: TRequest,
): ArmResponse<TResponse> | ArmAcceptedLroResponse | ErrorResponse;

@armResourceOperations(EvaluationEngine)
interface EvaluationEngineOperations {
  get is ArmResourceRead<EvaluationEngine>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<EvaluationEngine>;
  update is ArmResourcePatchAsync<EvaluationEngine, EvaluationEngineProperties>;
  delete is ArmResourceDeleteSync<EvaluationEngine>;
  listByResourceGroup is ArmResourceListByParent<EvaluationEngine>;
  listBySubscription is ArmListBySubscription<EvaluationEngine>;
  evaluate is ArmResourceListActionAsync<
    EvaluationEngine,
    EvaluationActionRequest,
    ResourceListResult<EvaluationActionResponse>
  >;
  checkApplicability is ArmResourceListActionAsync<
    EvaluationEngine,
    ApplicabilityActionRequest,
    ResourceListResult<ApplicabilityActionResponse>
  >;
  transpile is ArmResourceListActionAsync<
    EvaluationEngine,
    TranspileActionRequest,
    ResourceListResult<TranspileActionResponse>
  >;
}

@armResourceOperations
interface EvaluationEnginePolicyAssignmentOperations {
  get is ArmResourceRead<EvaluationEnginePolicyAssignment>;
  create is ArmResourceCreateOrReplaceSync<EvaluationEnginePolicyAssignment>;
  update is ArmResourcePatchSync<
    EvaluationEnginePolicyAssignment,
    EvaluationEnginePolicyAssignmentProperties
  >;
  delete is ArmResourceDeleteSync<EvaluationEnginePolicyAssignment>;
  listByParent is ArmResourceListByParent<EvaluationEnginePolicyAssignment>;
}

@armResourceOperations
interface EvaluationEnginePolicyDefinitionOperations {
  get is ArmResourceRead<EvaluationEnginePolicyDefinition>;
  create is ArmResourceCreateOrReplaceSync<EvaluationEnginePolicyDefinition>;
  update is ArmResourcePatchSync<
    EvaluationEnginePolicyDefinition,
    EvaluationEnginePolicyDefinitionProperties
  >;
  delete is ArmResourceDeleteSync<EvaluationEnginePolicyDefinition>;
  listByParent is ArmResourceListByParent<EvaluationEnginePolicyDefinition>;
}
