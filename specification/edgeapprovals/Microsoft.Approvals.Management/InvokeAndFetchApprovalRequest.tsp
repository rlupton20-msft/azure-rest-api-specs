using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("The input for the invokeAndFetchApprovalRequest POST call.")
model ApprovalRequestInput {
  @doc("The ARM resource ID of the ChangeState resource that the approval request is associated with.")
  changeStateId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ChangeSafety/changeStates";
    }
  ]>;

  @doc("The name of the current stage progression of the ChangeState resource.")
  stageProgression: string;

  @doc("The resource that the approval request is associated with, if multiple resources are included in the ChangeState.")
  resourceId?: Azure.Core.armResourceIdentifier;
}

@doc("The output for the invokeAndFetchApprovalRequest POST call.")
model ApprovalRequestOutput {
  @doc("The current state of the approval request.")
  approvalRequestState: ApprovalRequestState;

  @doc("The approval token of the approval request.")
  approvalToken: string;
}

@doc("Enum of approval request state.")
union ApprovalRequestState {
  string,

  @doc("The approval request in still in progress.")
  InProgress: "InProgress",

  @doc("The approval request has been approved.")
  Approved: "Approved",

  @doc("The approval request has been rejected.")
  Rejected: "Rejected",
}

@armResourceOperations
interface ApprovalRequest {
  @doc("The ProviderLevelAction POST call to invoke and fetch the approval request.")
  invokeAndFetchApprovalRequest is ArmProviderActionSync<
    ApprovalRequestInput,
    ArmResponse<ApprovalRequestOutput>,
    SubscriptionActionScope
  >;
}
