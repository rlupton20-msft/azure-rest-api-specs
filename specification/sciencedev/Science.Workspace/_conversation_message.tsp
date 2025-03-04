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

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

@doc("Data asset")
model DataAsset {
  @doc("DataAsset id")
  @visibility("read", "create")
  dataAssetId: DataAssetId;

  ...WithCreatedAt;
  ...WithCreatedBy;
}

@doc("For adding DataAsset ID")
model WithDataAssetId {
  /** ID of the related data asset */
  @visibility("read")
  dataAssetId: DataAssetId;
}

@doc("For adding key")
model WithKey {
  /** Key used as identifier */
  @visibility("read")
  key: string;
}
@doc("Copilot citation")
model Citation {
  ...WithKey;
  ...WithDataAssetId;

  /** URI from where citation originated */
  @visibility("read")
  sourceUri: string;

  /** Title to display */
  @visibility("read")
  title: string;

  /** Description */
  @visibility("read")
  description: string;
}

@doc("Command for the UI to invoke")
model UiCommand {
  /** Command */
  @visibility("read")
  command: string;

  /** Command */
  @visibility("read")
  status: string;

  /** Parameters */
  // TODO: Discuss modelling params
  //    @visibility("read")
  //    parameters: any; // TODO: Not sure if this is possible in TypeScript
}

@doc("Database query")
model DbQuery {
  ...WithKey;
  ...WithDataAssetId;

  /** Query */
  @visibility("read")
  query: string;

  /** Properties */
  @visibility("read")
  properties: string[];
}

@doc("Knowledge base response")
model KnowledgeBaseResponse {
  ...WithKey;

  /** Response */
  @visibility("read")
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

@doc("A body for creating a message.")
model MessageCreateBody {
  ...WithMessageText;

  @doc("Array of files to upload.")
  @visibility("read", "create")
  dataAssets: DataAsset[];
}

@access(Access.internal)
@doc("A base message.")
model MessageBase {
  ...WithId;
  ...WithProjectIdOptional;
  ...WithInvestigationIdOptional;
  ...MessageCreateBody;
  ...WithCreatedAt;
  ...WithCreatedBy;
  ...WithSender;

  @doc("Message status")
  @visibility("read")
  status: MessageStatus;

  @doc("The command name")
  @visibility("read")
  commandName?: string;

  @doc("Citation list")
  @visibility("read")
  citations: Citation[];

  @doc("Database query list")
  @visibility("read")
  dbQueries: DbQuery[];
}

@doc("A message.")
@resource("messages")
@parentResource(Conversation)
model ConversationMessage {
  @doc("The message name.")
  @visibility("read")
  @key("messageName")
  name: string;

  ...MessageBase;
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
    QueryParametersTrait<WithQueryProjectId &
      WithQueryInvestigationId &
      WithQueryCreatedSince>
  >;

  @doc("Cancel current copilot operation.")
  cancel is Operations.ResourceAction<
    ConversationMessage,
    {},
    ConversationMessage
  >;
}
