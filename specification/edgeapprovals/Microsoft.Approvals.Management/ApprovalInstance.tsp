using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Approvals;

@doc("The ApprovalInstance ARM resource")
model ApprovalInstance is TrackedResource<ApprovalInstanceProperties> {
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("ApprovalInstanceName")
  @segment("ApprovalInstances")
  @path
  name: string;
}

@doc("RP-specific properties of an ApprovalInstance resource")
model ApprovalInstanceProperties {
  @visibility("read")
  @doc("Status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("The ARM resource ID of the ApprovalDefinition resource that the ApprovalInstance was created from.")
  approvalDefinitionId: Azure.Core.armResourceIdentifier<[
    {type: "Microsoft.Approvals/approvalDefinitions"}
  ]>;

  @doc("The one who attempted to make the change that triggered the ApprovalInstance.")
  requestedBy: string;

  @doc("The datetime when the ApprovalInstance was triggered.")
  requestedDateTime: utcDateTime;

  @doc("The description of the change.")
  description: string;

  @doc("The change manifest associated with the ApprovalInstance, free-formed and could be base64 encoded.")
  changeManifest: string;

  @doc("The rule about how the approval workflow can be successfully completed, originated from the ApprovalDefinition resource at the time the ApprovalInstance was created")
  approvalRule: ApprovalRule;

  @doc("The current state of the approval instance.")
  state: ApprovalInstanceState;

  @doc("The latest status of each stage.")
  stageStatuses: ApprovalStageStatus[];
}

@doc("Enum of approval instance state.")
union ApprovalInstanceState {
  string,

  @doc("The approval workflow instance has started.")
  InProgress: "InProgress",

  @doc("The approval workflow instance has finished with all approval rules satisfied.")
  Succeeded: "Succeeded",

  @doc("The approval workflow instance has ended without approval rules satisfied.")
  Failed: "Failed"
}

@doc("Status of an approval stage.")
model ApprovalStageStatus {
  @doc("The name of the stage.")
  name: string;

  @doc("The state of the stage.")
  state: ApprovalStageState;

  @doc("The resource ids of ApproverSignoffs submitted in the stage.")
  signoffs: Azure.Core.armResourceIdentifier<[
    {type: "Microsoft.Approvals/approvalInstances/approverSignoffs"}
  ]>[];
}

@doc("Enum of approval stage state.")
union ApprovalStageState {
  string,

  @doc("The initial state of the approval stage.")
  Created: "Created",

  @doc("The approval stage is ready to accept signoffs.")
  Started: "Started",

  @doc("The approval stage has finished with approval rules satisfied.")
  Completed: "Completed",

  @doc("The approval stage has ended without approval rules satisfied.")
  Terminated: "Terminated"
}

@doc("Base info of a stage")
model ApprovalStageBasicInfo {

  @doc("The name of the stage")
  stageName: string;
}

@armResourceOperations(ApprovalInstance)
interface ApprovalInstances {
  get is ArmResourceRead<ApprovalInstance>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<ApprovalInstance>;
  update is ArmResourcePatchSync<ApprovalInstance, ApprovalInstanceProperties>;
  delete is ArmResourceDeleteSync<ApprovalInstance>;
  listByResourceGroup is ArmResourceListByParent<ApprovalInstance>;
  listBySubscription is ArmListBySubscription<ApprovalInstance>;
  startStage is ArmResourceActionNoContentSync<ApprovalInstance, ApprovalStageBasicInfo>;
  checkStage is ArmResourceActionSync<ApprovalInstance, ApprovalStageBasicInfo, ApprovalStageStatus>;
}
