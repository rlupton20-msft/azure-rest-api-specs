import "../Discovery.Shared/namespace.tsp";
import "@typespec/http";
import "../Discovery.Shared/data-plane.tsp";
import "../Discovery.Shared/shared.tsp";

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
  @visibility(Lifecycle.Read)
  sender: Sender;
}

@doc("For adding version ID.")
model WithVersionId {
  @doc("The version ID")
  @visibility(Lifecycle.Read)
  versionId: string;
}

@doc("For project reference.")
model WithProjectId {
  @doc("The ID of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectId: string;
}

@doc("For investigation reference.")
model WithInvestigationId {
  @doc("The ID of the associated Investigation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectId?: string;
}

@doc("For investigation reference.")
model WithInvestigationNameOptional {
  @doc("The Name of the associated Investigation")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  investigationName?: string;
}

@doc("For project name reference.")
model WithProjectNameOptional {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName?: string;
}

@doc("For required project name reference.")
model WithProjectName {
  @doc("The name of the associated Project")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  projectName: string;
}

@doc("For searching by Project.")
model WithQueryProjectName {
  @doc("The name of the associated Project")
  @TypeSpec.Http.query
  projectName?: string;
}

@doc("For searching by Investigation.")
model WithQueryInvestigationName {
  @doc("The name of the associated Investigation")
  @TypeSpec.Http.query
  investigationName?: string;
}
