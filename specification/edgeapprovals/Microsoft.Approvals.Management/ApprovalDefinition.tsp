using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.Approvals;

@doc("ApprovalDefinition ARM resource")
model ApprovalDefinition is TrackedResource<ApprovalDefinitionProperties> {
  @doc("The name of the ApprovalDefinition resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("approvalDefinitionName")
  @segment("approvalDefinitions")
  @path
  name: string;
}

@doc("RP-specific properties of an ApprovalDefinition resource")
model ApprovalDefinitionProperties {
  @visibility("read")
  @doc("Status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("Reference to a Logic App.")
  logicAppRef: LogicAppRef;

  @doc("Reference to an Azure Confidential Ledger.")
  ledgerRef: LedgerRef;

  @doc("Rule about how the approval workflow can be successfully completed.")
  approvalRule: ApprovalRule;
}

@doc("Reference to a Logic App resource.")
model LogicAppRef {
  @doc("The Logic App workflow URL.")
  workflowUrl: string;

  @doc("The Http method to use when invoking the workflow URL.")
  httpMethod: LogicAppHttpTriggerMethod;
}

@doc("Enum of Http methods to use when invoking a Logic App workflow.")
union LogicAppHttpTriggerMethod {
  string,

  @doc("The Http GET method.")
  GET: "GET",

  @doc("The Http POST method.")
  POST: "POST",

  @doc("The Http PUT method.")
  PUT: "PUT",
}

@doc("Reference to an Azure Confidential Ledger resource.")
model LedgerRef {
  @doc("The ARM resource ID of the ledger.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ConfidentialLedger/ledgers";
    }
  ]>;
}

@doc("Rule about how an approval workflow can be successfully completed.")
model ApprovalRule {
  @doc("The definitions of all the stages in the approval workflow.")
  @extension("x-ms-identifiers", ["name"])
  stageDefinitions: ApprovalStageDefinition[];

  @doc("The signature against the approval rule to prove its authenticity.")
  proof: string;

  @doc("The reference to the confidential ledger record about the rule.")
  ledgerRecord: LedgerRecord;
}

@doc("Definition of an approval stage.")
model ApprovalStageDefinition {
  @doc("The name of the stage, unique within a single ApprovalDefinition resource")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model"
  @doc("The logic rules in JSON about how the stage depends on other stages.")
  dependsOn: {};

  @doc("The set of approvers in the stage.")
  approvers: string[];

  @doc("The minimal number of approvals for completing the stage.")
  quorum: int32;
}

@armResourceOperations(ApprovalDefinition)
interface ApprovalDefinitions {
  get is ArmResourceRead<ApprovalDefinition>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ApprovalDefinition>;
  update is ArmResourcePatchSync<
    ApprovalDefinition,
    ApprovalDefinitionProperties
  >;
  delete is ArmResourceDeleteSync<ApprovalDefinition>;
  listByResourceGroup is ArmResourceListByParent<ApprovalDefinition>;
  listBySubscription is ArmListBySubscription<ApprovalDefinition>;
}
