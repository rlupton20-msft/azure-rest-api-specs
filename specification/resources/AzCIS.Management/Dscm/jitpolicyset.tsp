import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCIS;

@doc("JitPolicySet properties")
model JitPolicySetProperties {
  @doc("The cloud ID for the request")
  cloud: string; // camel case for the parameter name

  @doc("The resource type for the policyset request")
  resourceType: string;

  @doc("List of policy objects associated with the resource to be updated or added")
  @extension("x-ms-identifiers", [])
  policies?: Array<Policy>;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: DscmProvisioningState;
}

@doc("Policy.")
model Policy {
  @doc("The unique identifier for the policy (unique per cloud per service)")
  policyInvariableId: int64;

  @doc("The unique identifier for the policy")
  policyId: string;

  @doc("The execution sequence for the policy.")
  executionSequence: int64;

  @doc("The extended flags for the policy.")
  extendedFlags: int64;

  @doc("The cloud for the policy request.")
  cloud: string;

  @doc("The resource type for the policy.")
  resourceType: string;

  @doc("The type of policy.")
  policyType: string;

  @doc("List of condition objects that must be validated.")
  @extension("x-ms-identifiers", [])
  policyConditions?: Array<PolicyCondition>;

  @doc("List of action objects that can be performed after validation.")
  @extension("x-ms-identifiers", [])
  policyActions?: Array<PolicyAction>;
}

@doc("Policy condition for evaluation.")
model PolicyCondition {
  @doc("Operator for the policy to be evaluated.")
  operator: string;

  @doc("The name of entity.")
  entityName: string;

  @doc("The value of entity.")
  entityValue: string;

  @doc("The value of property.")
  property: string;
}

@doc("Policy action performed after condition is met.")
model PolicyAction {
  @doc("The type of property action.")
  propertyType: string;

  @doc("The name of property.")
  propertyName: string;

  @doc("The value of property.")
  propertyValue: string;
}

@doc("JitPolicySet Resource")
model JitPolicySetResource
  is ProxyResource<JitPolicySetProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("jitPolicySets") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface JitPolicySet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<JitPolicySetResource>;
  listBySubscription is ArmListBySubscription<JitPolicySetResource>;
  listByResourceGroup is ArmResourceListByParent<JitPolicySetResource>;
  get is ArmResourceRead<JitPolicySetResource>;
}
