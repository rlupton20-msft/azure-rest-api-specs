import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

@doc("For adding message text")
model WithMessageText {
  @doc("The message text.")
  @visibility("read", "create")
  text: string;
}

@doc("For adding conversation ID")
model WithConversationId {
  @doc("The ID of the associated Conversation.")
  @visibility("read", "create")
  conversationId: string;
}

@access(Access.internal)
@doc("A base message.")
model MessageBase {
  ...WithProjectIdOptional;
  ...WithInvestigationIdOptional;
  ...WithConversationId;
  ...WithMessageText;
}
@doc("A message.")
@resource("messages")
model Message {
  ...MessageBase;
  ...WithCreatedAt;
  ...WithSender;

  @doc("The message name.")
  @visibility("read")
  @key("messageName")
  name: string;

  @doc("The plan Blueprint as YAML")
  @visibility("read")
  planBlueprintYaml?: string;
}

interface Messages {
  @doc("Fetch a Message by name.")
  getMessage is ResourceRead<Message>;

  // TODO: Convert to PUT
  @doc("Add an input.")
  createMessage is Operations.ResourceAction<Message, MessageBase, Message>;

  //  @doc("Delete a Message asynchronously.")
  //  @pollingOperation(Messages.getMessageOperationStatus)
  //  deleteMessage is LongRunningResourceDelete<Message>;

  @doc("List Message resources")
  listMessages is ResourceList<
    Message,
    QueryParametersTrait<WithQueryConversationId &
      WithQueryProjectId &
      WithQueryInvestigationId &
      WithQueryCreatedSince>
  >;
}
