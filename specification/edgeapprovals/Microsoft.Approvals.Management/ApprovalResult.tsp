using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("The ApprovalResult resource")
model ApprovalResult is ProxyResource<ApprovalResultProperties> {
  @doc("The name of the ApprovalResult resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("approvalResultName")
  @segment("approvalResults")
  @visibility("read")
  @path
  name: string;
}

@doc("RP-specific properties of an ApprovalResult resource")
model ApprovalResultProperties {
  @visibility("read")
  @doc("Status of the last operation.")
  provisioningState?: ProvisioningState;

  @visibility("read")
  @doc("The current state the approval request.")
  approvalRequestState: ApprovalRequestState;
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

@armResourceOperations(ApprovalResult)
interface ApprovalResults {
  get is ArmResourceRead<ApprovalResult>;
  list is ArmResourceListAtScope<ApprovalResult>;
  listBySubscription is ArmListBySubscription<ApprovalResult>;
}
