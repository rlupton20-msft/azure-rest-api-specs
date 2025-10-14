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

@versioned(Microsoft.Discovery.Workspace.Versions)
namespace Microsoft.Discovery.Workspace;

@added(Versions.`2025-07-01-preview`)
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

@added(Versions.`2025-07-01-preview`)
@doc("A user confirmation for a copilot action related to a message.")
@resource("confirmations")
@parentResource(ConversationMessage)
model MessageConfirmation {
  @doc("The confirmation name/key.")
  @visibility(Lifecycle.Read)
  @key("confirmationName")
  name: string;

  ...DataPlaneResource;

  @doc("Confirmation status")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  status: ConfirmationStatus;

  @doc("Reason for status (e.g. deny reason)")
  @visibility(Lifecycle.Read, Lifecycle.Update)
  statusReason?: string;

  @doc("Name of the agent seeking confirmation")
  @visibility(Lifecycle.Read)
  agentName?: string;

  @doc("Name of the tool seeking confirmation")
  @visibility(Lifecycle.Read)
  toolName?: string;

  @doc("Arguments for the tool")
  @visibility(Lifecycle.Read)
  toolArguments?: string;
}
