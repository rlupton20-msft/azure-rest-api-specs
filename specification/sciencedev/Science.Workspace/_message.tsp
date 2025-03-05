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

@doc("A message.")
@resource("messages")
model Message {
  @doc("The message name.")
  @visibility(Lifecycle.Read)
  @key("messageName")
  name: string;

  ...MessageBase;
}

@route("/")
interface Messages {
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
