using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("The ApproverSignoff ARM resource")
@parentResource(ApprovalInstance)
model ApproverSignoff is TrackedResource<ApproverSignoffProperties> {
  @doc("The name of the ApproverSignoff resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("approverSignoffName")
  @segment("approverSignoffs")
  @path
  name: string;
}

@doc("RP-specific properties of an ApproverSignoff resource")
model ApproverSignoffProperties {
  @visibility("read")
  @doc("Status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The ARM resource ID of the ApprovalDefinition resource that the ApproverSignoff was created from.")
  approvalDefinitionId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Approvals/approvalDefinitions";
    }
  ]>;

  @doc("The one who took the signoff action.")
  approver: string;

  @doc("The name of the approval stage from where the signoff was originated.")
  stageName: string;

  @doc("The action the approver took.")
  signoffAction: ApproverSignoffAction;

  @doc("The datetime when the approver took the signoff action.")
  signoffDateTime: utcDateTime;

  @doc("The content of which the signoff is about, free-formed and could be base64 encoded.")
  signoffManifest: string;

  @doc("The signatures from the approvers for the signoff, could be base64 encoded")
  signatures: string[];

  @doc("The reference to the confidential ledger record about the signoff.")
  ledgerRecord: LedgerRecord;
}

@doc("Enum of approver signoff action.")
union ApproverSignoffAction {
  string,

  @doc("The approver hasn't take any action.")
  Pending: "Pending",

  @doc("The approver has approved.")
  Approved: "Approved",

  @doc("The approver has rejected.")
  Rejected: "Rejected",
}

@armResourceOperations(ApproverSignoff)
interface ApproverSignoffs {
  get is ArmResourceRead<ApproverSignoff>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApproverSignoff>;
  update is ArmResourcePatchSync<ApproverSignoff, ApproverSignoffProperties>;
  delete is ArmResourceDeleteSync<ApproverSignoff>;
  listByParent is ArmResourceListByParent<ApproverSignoff>;
}
