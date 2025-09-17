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

@versioned(Microsoft.AiForScience.Workspace.Versions)
namespace Microsoft.AiForScience.Workspace;

@doc("A message.")
@resource("messages")
model Message {
  @doc("The message name.")
  @visibility("read")
  @key("messageName")
  name: string;

  ...WithId;
  ...MessageBase;
}

// TODO: Remove un-needed route prefix!
@route("/")
interface Messages {
  //  @doc("Fetch a Message by name.")
  //  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops"
  //  @route("/")
  //  getMessage is ResourceRead<Message>;
  //
  //  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  //  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops"
  //  @doc("Creates a Message.")
  //  @createsOrReplacesResource(Message)
  //  @route("/messages")
  //  @post
  //  createMessage is Azure.Core.Foundations.Operation<
  //    Message,
  //    Message,
  //    Message
  //  >;

  //  @doc("Delete a Message asynchronously.")
  //  @pollingOperation(Messages.getMessageOperationStatus)
  //  deleteMessage is LongRunningResourceDelete<Message>;

  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops"
  @doc("List Messages across conversations")
  @route("/")
  listMessages is ResourceList<
    Message,
    QueryParametersTrait<WithQueryConversationId &
      WithQueryProjectId &
      WithQueryInvestigationId &
      WithQueryCreatedSince>
  >;
}
