import "../Science.Shared/all.tsp";
import "@typespec/http";

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

/** Enum for runMode */
union RunMode {
  /** Run every step */
  RunAll: "RunAll",

  /** Run after last completed step */
  PauseAfterStep: "PauseAfterStep",

  string,
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
