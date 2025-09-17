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

@added(Versions.`2025-07-01-preview`)
@doc("A copilot log related to a message.")
@resource("logs")
@parentResource(ConversationMessage)
model MessageLog {
  @doc("The Log name/key.")
  @visibility(Lifecycle.Read)
  @key("logName")
  name: string;

  @doc("Log sender")
  @visibility(Lifecycle.Read)
  sender: string;

  @doc("Log text")
  @visibility(Lifecycle.Read)
  text: string;

  ...WithCreatedAt;
}

// TODO: Spend more time on this hack to get it to look how we want without conventional ResourceList
/** Hack to avoid  using Azure recommended ResourceList */
// model LogList {
//   /** List of messages similar to ResourceList.  */
//   value: Array<MessageLog>
// }
@added(Versions.`2025-07-01-preview`)
interface MessageLogs {
  //   @doc("Fetch a Message by name.")
  //   getLog is ResourceRead<MessageLog>;

  @doc("List Messages in specified conversation")
  listLogs is ResourceList<
    MessageLog,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  // TODO: Spend more time on this hack to get it to look how we want without conventional ResourceList
  //   #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  //   #suppress "@azure-tools/typespec-azure-core/verb-conflict"
  //   @doc("List Messages in specified conversation")
  //   @get
  //   listLogs is Operations.ResourceAction<
  //     MessageLog,
  //     QueryParametersTrait<WithQueryCreatedSince>,
  //     LogList
  //   >;
}
