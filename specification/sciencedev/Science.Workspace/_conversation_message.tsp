import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;
using Microsoft.Science.Shared;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("Data asset")
model DataAsset {
  @doc("DataAsset id")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dataAssetId: DataAssetId;

  /** Asset name */
  // TODO: Are we sure we want/need this?
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;

  ...WithCreated;
}

@doc("A body for creating a message.")
model MessageCreateBody {
  ...WithMessageText;

  //   @doc("Array of files to upload.")
  //   @visibility(Lifecycle.Read, Lifecycle.Create)
  //   dataAssets: DataAsset[];
}

@doc("For adding DataAsset ID")
model WithDataAssetId {
  /** ID of the related data asset */
  @visibility(Lifecycle.Read)
  dataAssetId: DataAssetId;
}

@doc("For adding key")
model WithKey {
  /** Key used as identifier */
  @visibility(Lifecycle.Read)
  key: string;
}
@doc("Copilot citation")
model Citation {
  ...WithKey;
  ...WithDataAssetId;

  /** URI from where citation originated */
  @visibility(Lifecycle.Read)
  sourceUri: string;

  /** Title to display */
  @visibility(Lifecycle.Read)
  title: string;

  /** Description */
  @visibility(Lifecycle.Read)
  description: string;
}

@doc("Command for the UI to invoke")
model UiCommand {
  /** Command */
  @visibility(Lifecycle.Read)
  command: string;

  /** Command */
  @visibility(Lifecycle.Read)
  status: string;

  /** Parameters */
  // TODO: Discuss modelling params
  //    @visibility(Lifecycle.Read)
  //    parameters: any; // TODO: Not sure if this is possible in TypeScript
}

@doc("Database query")
model DbQuery {
  ...WithKey;
  ...WithDataAssetId;

  /** Query */
  @visibility(Lifecycle.Read)
  query: string;

  /** Properties */
  @visibility(Lifecycle.Read)
  properties: string[];
}

@doc("Knowledge base response")
model KnowledgeBaseResponse {
  ...WithKey;

  /** Response */
  @visibility(Lifecycle.Read)
  response: string;
}

@doc("Copilot operation")
model CopilotOperation {
  ...WithStatus<string>;
  ...WithCreatedAt;
}

@doc("For adding message text")
model WithMessageText {
  @doc("The message text.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  text: string;
}

@doc("For adding conversation ID")
model WithConversationId {
  @doc("The ID of the associated Conversation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  conversationId: string;
}

@doc("Enumeration for message status.")
union MessageStatus {
  /** Message Accepted */
  Accepted: "Accepted",

  /** Message is awaiting user input */
  AwaitingUserInput: "AwaitingUserInput",

  /** Message is Processing */
  Processing: "Processing",

  /** Message Completed */
  Completed: "Completed",

  /** Message Failed */
  Failed: "Failed",

  string,
}

@doc("A message.")
@resource("messages")
@parentResource(Conversation)
model ConversationMessage {
  @doc("The message name.")
  @visibility(Lifecycle.Read)
  @key("messageName")
  name: string;

  ...DataPlaneResource;

  //   ...WithProjectIdOptional;
  ...WithInvestigationIdOptional;

  ...WithSender;

  @doc("Message status")
  @visibility(Lifecycle.Read)
  status?: MessageStatus;

  //   @doc("The command name")
  //   @visibility(Lifecycle.Read)
  //   commandName?: string;

  @doc("Citation list")
  @visibility(Lifecycle.Read)
  citations?: Citation[];

  @doc("Array of data assets.")
  @visibility(Lifecycle.Read)
  dataAssets?: DataAsset[];

  //   @doc("Database query list")
  //   @visibility(Lifecycle.Read)
  //   dbQueries?: DbQuery[];
}

alias ConversationPathContent = {
  @doc("The conversation name.")
  @path
  conversationName: string;
};

// TODO: Remove un-needed route prefix!
//@route("copilot")
interface ConversationMessages {
  @doc("Fetch a Message by name.")
  getMessage is ResourceRead<ConversationMessage>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a Message.")
  @createsOrReplacesResource(ConversationMessage)
  @route("/conversations/{conversationName}/messages")
  @post
  createMessage is Azure.Core.Foundations.Operation<
    ConversationPathContent & MessageCreateBody,
    ConversationMessage
  >;

  @doc("List Messages in specified conversation")
  listMessages is ResourceList<
    ConversationMessage,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  #suppress "@azure-tools/typespec-azure-core/no-explicit-routes-resource-ops"
  @doc("List Messages across conversations")
  @route("/messages")
  listMessagesByWorkspace(
    ...Azure.ResourceManager.ApiVersionParameter,
    ...WithQueryConversationId,
    ...WithQueryCreatedSince,
    ...WithQueryInvestigationId,
    ...WithQueryProjectId,
  ): Paged<ConversationMessage> | Azure.Core.Foundations.ErrorResponse;

  @doc("Cancel current copilot operation.")
  cancel is Operations.ResourceAction<
    ConversationMessage,
    {},
    ConversationMessage
  >;
}
