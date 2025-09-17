import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Science.Shared;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("A conversation.")
@resource("conversations")
model Conversation {
  @doc("The conversation name.")
  @visibility(Lifecycle.Read)
  @key("conversationName")
  name: string;

  ...DataPlaneResource;
  ...WithTitle;
  ...WithInvestigationIdOptional;
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
    WithInvestigationIdOptional,
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
    QueryParametersTrait<WithQueryInvestigationId & WithQueryCreatedSince>
  >;
}
