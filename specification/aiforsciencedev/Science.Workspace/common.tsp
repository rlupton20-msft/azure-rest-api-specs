import "../Science.Shared/all.tsp";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Versioning;

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("Enumeration for message sender.")
union Sender {
  /** Sent by Copilot */
  Copilot: "Copilot",

  /** Sent by User */
  You: "You",

  string,
}

@doc("For adding message sender.")
model WithSender {
  @doc("The sender")
  @visibility("read")
  sender: Sender;
}

@doc("For adding version ID.")
model WithVersionId {
  @doc("The version ID")
  @visibility("read")
  versionId: string;
}

@doc("For project reference.")
model WithProjectId {
  @doc("The ID of the associated Project")
  @visibility("read", "create")
  projectId: string;
}

@doc("For investigation reference.")
model WithInvestigationId {
  @doc("The ID of the associated Investigation")
  @visibility("read", "create")
  investigationId: string;
}

@doc("For pan reference.")
model WithPlanId {
  @doc("The ID of the associated plan")
  @visibility("read")
  planId: string;
}

@doc("For run reference.")
model WithRunId {
  @doc("The ID of the associated plan run")
  @visibility("read")
  runId: string;
}

/** Enum for runMode */
union RunMode {
  /** Run every step */
  RunAll: "RunAll",

  /** Run after last completed step */
  PauseAfterStep: "PauseAfterStep",

  string,
}

@doc("Step within a plan")
model Step {
  //  @doc("The step name.")
  //  @visibility("read")
  //  @key("stepName")
  //  name: string;

  //  ...WithCreatedAt;
  //  ...WithUpdatedAt;
  //  ...WithStatus<RunStatus>;
  //  ...WithStatusReason;
  //  ...WithResultAsset;

  @doc("The step order.")
  @visibility("read")
  stepNumber: int32;

  // TODO: What does actionId mean? I'm not clear how this differs from step name. Is this the same as "activityId" from run step?
  @doc("The step action ID.")
  @visibility("read")
  actionId: string;

  @doc("The ID of the associated Tool within Catalog.")
  @visibility("read")
  toolId: string;

  @doc("The step category.")
  @visibility("read")
  category: string;
}

@doc("For adding run mode.")
model WithRunMode {
  @doc("The mode of the plan run")
  @visibility("read", "create")
  runMode?: RunMode;
}

@doc("For adding Plan Blueprint yaml.")
model WithYaml {
  @doc("The plan Blueprint as YAML")
  @visibility("read", "create", "update")
  planBlueprintYaml?: string;
}

@doc("For project reference.")
model WithProjectIdOptional {
  @doc("The ID of the associated Project")
  @visibility("read", "create")
  projectId?: string;
}

@doc("For investigation reference.")
model WithInvestigationIdOptional {
  @doc("The ID of the associated Investigation")
  @visibility("read", "create")
  investigationId?: string;
}

@doc("For searching by Project.")
model WithQueryProjectId {
  @doc("The ID of the associated Project")
  @TypeSpec.Http.query
  projectId?: string;
}

@doc("For searching by Investigation.")
model WithQueryInvestigationId {
  @doc("The ID of the associated Investigation")
  @TypeSpec.Http.query
  investigationId?: string;
}

//@doc("For searching by InvestigationVersion.")
//model WithQueryInvestigationVersionId {
//  @doc("The ID of the associated InvestigationVersion")
//  @TypeSpec.Http.query
//  investigationVersionId?: string;
//}

@doc("For searching by Conversation.")
model WithQueryConversationId {
  @doc("The ID of the associated Conversation")
  @TypeSpec.Http.query
  conversationId?: string;
}

@doc("Linked DataSets.")
model LinkedDataSets {
  @doc("Fully qualified resource ID for the DataSet resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Science/DataAssets/{assetName}/DataSets/{setName}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/DataAssets/DataSets";
    }
  ]>;
}

@doc("Linked Storage.")
model LinkedStorage {
  @doc("Fully qualified resource ID for the Science Storage account. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Science/storages/{accountName}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/storages"; // TODO: Change to Science shared storage?
    }
  ]>;
}

@doc("Linked NodePools.")
model LinkedNodePools {
  @doc("Fully qualified resource ID for the NodePool resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Science/supercomputers/{scName}/nodepools/{name}")
  @visibility("read", "create", "update")
  id: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Science/supercomputers/nodepools";
    }
  ]>;
}
