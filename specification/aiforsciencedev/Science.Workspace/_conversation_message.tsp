import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_conversation.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

/**
User Request allows:

{
    "projectId": "string",
    "investigationId": "string",
    "text": "string",
    "sender": "User",
    "context": {
        "planBlueprintYaml": "this can be sent if the user is currently drafting a plan with copilot, and if it is not sent,  copilot will see the latest saved plan in the DB",
        "fileUploads": [
            {
                "blobUri": "https://example.com/file1",
                "internalReferenceId": "file1"
            }
        ]
    }
}


*/
@doc("File upload")
model FileUpload {
  ...WithKey;

  /** URI of the file */
  @visibility("read")
  blobUri: string;
}

@doc("For adding artifact ID")
model WithArtifactId {
  /** ID of the related artifact */
  @visibility("read")
  artifactId: string;
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
  ...WithArtifactId;

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
  ...WithArtifactId;

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

  /** Message is Processing */
  Processing: "Processing",

  /** Message Completed */
  Completed: "Completed",

  /** Message Failed */
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
  ...WithCreatedAt;
  ...WithSender;

  @doc("Message status")
  @visibility("read")
  status: MessageStatus;

  @doc("The plan Blueprint as YAML")
  @visibility("read", "create")
  planBlueprintYaml?: string;

  @doc("Array of files to upload.")
  @visibility("read", "create")
  fileUploads: FileUpload[];

  @doc("The command name")
  @visibility("read")
  commandName?: string;

  @doc("Copilot Operations")
  copilotOperations: CopilotOperation[];

  @doc("Citation list")
  @visibility("read")
  citations: Citation[];

  @doc("UI command list")
  @visibility("read")
  uiCommands: UiCommand[];

  @doc("Database query list")
  @visibility("read")
  dbQueries: DbQuery[];

  @doc("knowledge base responses list")
  @visibility("read")
  knowledgeBaseResponses: KnowledgeBaseResponse[];
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

alias ConversartionPathContent = {
  @doc("The ID of the Pool that contains the Compute Node.")
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
    ConversartionPathContent & ConversationMessage,
    ConversationMessage,
    ConversationMessage
  >;

  // TODO: Consider adding this so client can update message state.
  //  @doc("Creates or updates Message.")
  //  createOrUpdateMessage is StandardResourceOperations.ResourceCreateOrUpdate<Message>;

  //  @doc("Delete a Message asynchronously.")
  //  @pollingOperation(Messages.getMessageOperationStatus)
  //  deleteMessage is LongRunningResourceDelete<Message>;

  @doc("List Messages in specified conversation")
  listMessages is ResourceList<
    ConversationMessage,
    QueryParametersTrait<WithQueryProjectId &
      WithQueryInvestigationId &
      WithQueryCreatedSince>
  >;
}
