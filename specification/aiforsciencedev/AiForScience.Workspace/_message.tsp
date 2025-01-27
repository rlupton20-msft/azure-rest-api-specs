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

@doc("Enumeration for message status.")
union MessageStatus {
  /** Accepted */
  Accepted: "Accepted",

  /** Processing */
  Processing: "Processing",

  /** Completed */
  Completed: "Completed",

  /** Failed */
  Failed: "Failed",

  string,
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

  @doc("Message status")
  @visibility("read")
  status: MessageStatus;

  @doc("The plan Blueprint as YAML")
  @visibility("read")
  planBlueprintYaml?: string;
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Messages {
  @doc("Fetch a Message by name.")
  getMessage is ResourceRead<Message>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates or updates Message.")
  @createsOrReplacesResource(Message)
  @put
  @route("/messages")
  createOrReplaceMessage is Azure.Core.Foundations.Operation<
    Message,
    MessageBase,
    Message
  >;

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
