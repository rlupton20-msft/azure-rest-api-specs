import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("A conversation.")
@resource("conversations")
model Conversation {
  ...WithId;

  @doc("The conversation name.")
  @visibility("read")
  @key("conversationName")
  name: string;

  ...WithTitle;
  ...WithCreatedAt;
  ...WithUpdatedAt;
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Conversations {
  @doc("Fetch a Conversation by name.")
  getConversation is ResourceRead<Conversation>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a Conversation.")
  @createsOrReplacesResource(Conversation)
  @route("/conversations")
  @post
  createConversation is Azure.Core.Foundations.Operation<
    {},
    Conversation,
    Conversation
  >;

  @doc("Creates or updates a Conversation.")
  createOrUpdateConversation is StandardResourceOperations.ResourceCreateOrUpdate<Conversation>;

  //  @doc("Delete a Conversation asynchronously.")
  //  @pollingOperation(Conversations.getConversationOperationStatus)
  //  deleteConversation is LongRunningResourceDelete<Conversation>;

  @doc("List Conversation resources")
  listConversations is ResourceList<
    Conversation,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
