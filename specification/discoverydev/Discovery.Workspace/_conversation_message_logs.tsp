import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation_message.tsp";
import "../Discovery.Shared/data-plane.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@doc("Enumeration for log type.")
union LogType {
  @doc("Tool invocation log.")
  ToolInvocation: "ToolInvocation",

  @doc("Agent invocation log.")
  AgentInvocation: "AgentInvocation",

  @doc("Log event for generating a summary or output.")
  Generate: "Generate",

  string,
}

@doc("Enumeration for tool type.")
union ToolType {
  @doc("Hosted tool.")
  Hosted: "Hosted",

  @doc("OpenAPI tool.")
  OpenAPI: "OpenAPI",

  @doc("Function tool.")
  Function: "Function",

  @doc("Built-in tool.")
  BuiltIn: "BuiltIn",

  @doc("Remote tool.")
  Remote: "Remote",

  string,
}

@doc("Log level for a message log.")
union LogLevel {
  @doc("Information log level.")
  Information: "Information",

  string,
}

@added(Versions.`2025-07-01-preview`)
@doc("A copilot log related to a message.")
@resource("logs")
@parentResource(ConversationMessage)
model MessageLog {
  @doc("The Log name/key.")
  @visibility(Lifecycle.Read)
  @key("logName")
  name: string;

  @doc("The identifier of the conversation this log belongs to.")
  conversationId: string;

  @doc("The identifier of the message this log is associated with.")
  messageId: string;

  @doc("The timestamp of the log entry in ISO 8601 format.")
  timestamp: string;

  @doc("The log level for this entry.")
  logLevel: LogLevel;

  @doc("The type of activity for this log entry.")
  type: LogType;

  @doc("The type of tool, if applicable.")
  toolType?: ToolType;

  @doc("The name of the tool, if applicable.")
  toolName?: string;

  @doc("The arguments passed to the tool, if applicable.")
  toolArguments?: string;

  @doc("Indicates if this log entry represents an action.")
  isAction?: boolean;

  @doc("The destination agent, if applicable.")
  destinationAgent?: string;

  @doc("The sender of the log entry.")
  sender: string;

  @doc("The text content of the log entry.")
  text: string;

  @doc("The status of the activity represented by this log entry.")
  status: string;

  @doc("The creation time of the log entry (Unix timestamp).")
  createdAt: int64;

  @doc("The completion time of the log entry (Unix timestamp).")
  completedAt: int64;
}

@added(Versions.`2025-07-01-preview`)
@doc("Operations for message logs in a conversation.")
interface MessageLogs {
  //   @doc("Fetch a Message by name.")
  //   getLog is ResourceRead<MessageLog>;

  @doc("List message logs in the specified conversation.")
  listLogs is ResourceList<
    MessageLog,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
