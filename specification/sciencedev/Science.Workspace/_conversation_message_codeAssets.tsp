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

@doc("A CodeAsset related to a message.")
@resource("codeAssets")
@parentResource(ConversationMessage)
model MessageCodeAsset {
  @doc("The CodeAsset name/key.")
  @visibility("read")
  @key("CodeAssetName")
  name: string;

  @doc("CodeAsset id")
  @visibility("read")
  dataAssetId: string;

  @doc("CodeAsset programming language")
  @visibility("read")
  programmingLanguage: string;

  ...WithCreatedAt;
  ...WithCreatedBy;

  //   @doc("Name of the agent seeking CodeAsset")
  //   @visibility("read")
  //   agentName?: string;
  //
  //   @doc("Name of the tool seeking CodeAsset")
  //   @visibility("read")
  //   toolName?: string;
}

interface MessageCodeAssets {
  //   @doc("Fetch a Message by name.")
  //   getCodeAsset is ResourceRead<MessageCodeAsset>;

  @doc("List Messages in specified conversation")
  listCodeAssets is ResourceList<
    MessageCodeAsset,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
