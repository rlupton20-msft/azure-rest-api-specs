import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation_message.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("A copilot log related to a message.")
@resource("logs")
@parentResource(ConversationMessage)
model MessageLog {
  @doc("The Log name/key.")
  @visibility("read")
  @key("LogName")
  name: string;

  @doc("Log sender")
  @visibility("read")
  sender: string;

  @doc("Log text")
  @visibility("read")
  text: string;

  ...WithCreatedAt;

  //   @doc("Name of the agent seeking Log")
  //   @visibility("read")
  //   agentName?: string;
  //
  //   @doc("Name of the tool seeking Log")
  //   @visibility("read")
  //   toolName?: string;
}

interface MessageLogs {
  //   @doc("Fetch a Message by name.")
  //   getLog is ResourceRead<MessageLog>;

  @doc("List Messages in specified conversation")
  listLogs is ResourceList<
    MessageLog,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
