import "@typespec/http";
using Azure.Core;
using Azure.Core.Traits;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

@doc("Definition of Tag")
model Tag {
  @doc("Property key")
  key?: string;

  @doc("Property value")
  value?: string;
}

@doc("For adding tags.")
model WithTags {
  @doc("The tags")
  @visibility("read", "create", "update")
  tags?: Tag[];
}

@doc("For adding title to display instead of name.")
model WithTitle {
  @doc("The title")
  @visibility("read", "create", "update")
  // Defaults to name."
  title: string;
}

@doc("For adding status.")
model WithStatus<T> {
  @doc("The status")
  @visibility("read")
  status: T;
}

@doc("For adding status reason")
model WithStatusReason {
  @doc("The reason for the current status")
  @visibility("read")
  statusReason?: string;
}

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

@doc("For adding description.")
model WithDescription {
  @doc("The description")
  @visibility("read", "create", "update")
  description: string;
}

@doc("For adding version ID.")
model WithVersionId {
  @doc("The version ID")
  @visibility("read")
  versionId: string;
}

@doc("For adding creation timestamp.")
model WithCreatedAt {
  @doc("The timestamp when the resource was created")
  @visibility("read")
  createdAt: utcDateTime;
}

@doc("For tracking who created a resource.")
model WithCreatedBy {
  @doc("The ID of the user who created this resource.")
  @visibility("read")
  createdBy: string;
}

@doc("For adding last update timestamp.")
model WithUpdatedAt {
  @doc("The timestamp when the resource was last updated")
  @visibility("read")
  updatedAt: utcDateTime;
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

  /** Run after last compelted step step */
  PauseAfterStep: "PauseAfterStep",

  string,
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
  planBlueprintYaml: string;
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

@doc("For searching by InvestigationVersion.")
model WithQueryInvestigationVersionId {
  @doc("The ID of the associated InvestigationVersion")
  @TypeSpec.Http.query
  investigationVersionId?: string;
}

@doc("For searching by Conversation.")
model WithQueryConversationId {
  @doc("The ID of the associated Conversation")
  @TypeSpec.Http.query
  conversationId?: string;
}

@doc("For searching items created after specified timestamp.")
model WithQueryCreatedSince {
  @doc("The oldest creation timestamp to keep")
  @TypeSpec.Http.query
  createdSince?: utcDateTime;
}
