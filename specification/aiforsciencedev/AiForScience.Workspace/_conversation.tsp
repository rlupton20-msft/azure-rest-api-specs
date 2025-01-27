import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

@doc("A conversation.")
@resource("conversations")
model Conversation {
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithProjectIdOptional;
  ...WithInvestigationIdOptional;
  ...WithTitle;

  @doc("The conversation name.")
  @visibility("read", "create")
  @key("conversationName")
  name: string;
}

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface Conversations {
  @doc("Fetch a Conversation by name.")
  getConversation is ResourceRead<Conversation>;

  @doc("Creates or updates a Conversation asynchronously.")
  createOrUpdateConversation is StandardResourceOperations.ResourceCreateOrUpdate<Conversation>;

  //  @doc("Delete a Conversation asynchronously.")
  //  @pollingOperation(Conversations.getConversationOperationStatus)
  //  deleteConversation is LongRunningResourceDelete<Conversation>;

  @doc("List Conversation resources")
  listConversations is ResourceList<
    Conversation,
    QueryParametersTrait<WithQueryProjectId &
      WithQueryInvestigationId &
      WithQueryCreatedSince>
  >;
}
