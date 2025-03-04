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

@doc("Enumeration for message status.")
union ConfirmationStatus {
  /** Message is awaiting user input */
  AwaitingUserInput: "AwaitingUserInput",

  /** Message Confirmed */
  Confirmed: "Confirmed",

  /** Message Denied */
  Denied: "Denied",

  string,
}

@doc("A user confirmation for a copilot action related to a message.")
@resource("confirmations")
@parentResource(ConversationMessage)
model MessageConfirmation {
  @doc("The confirmation name/key.")
  @visibility("read")
  @key("confirmationName")
  name: string;

  @doc("Confirmation status")
  @visibility("read", "update")
  status: ConfirmationStatus;

  @doc("Reason for status (e.g. deny reason)")
  @visibility("read", "update")
  statusReason?: string;

  ...WithCreatedAt;
  ...WithCreatedBy;

  @doc("Name of the agent seeking confirmation")
  @visibility("read")
  agentName?: string;

  @doc("Name of the tool seeking confirmation")
  @visibility("read")
  toolName?: string;

  @doc("Arguments for the tool")
  @visibility("read")
  toolArguments?: string;
}

interface MessageConfirmations {
  @doc("Fetch a Message by name.")
  getConfirmation is ResourceRead<MessageConfirmation>;

  @doc("List Messages in specified conversation")
  listConfirmations is ResourceList<
    MessageConfirmation,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  @doc("Creates or updates MessageConfirmation.")
  createOrUpdateConfirmation is StandardResourceOperations.ResourceCreateOrUpdate<MessageConfirmation>;
}
