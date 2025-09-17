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
@doc("A DataAsset related to a message.")
@resource("dataAssets")
@parentResource(ConversationMessage)
model MessageDataAsset {
  @doc("The DataAsset name/key.")
  @visibility(Lifecycle.Read)
  @key("dataAssetName")
  name: string;

  @doc("DataAsset id")
  @visibility(Lifecycle.Read)
  dataAssetId: string;

  ...WithCreated;

  //   @doc("Name of the agent seeking DataAsset")
  //   @visibility(Lifecycle.Read)
  //   agentName?: string;
  //
  //   @doc("Name of the tool seeking DataAsset")
  //   @visibility(Lifecycle.Read)
  //   toolName?: string;
}

@added(Versions.`2025-07-01-preview`)
interface MessageDataAssets {
  //   @doc("Fetch a Message by name.")
  //   getDataAsset is ResourceRead<MessageDataAsset>;

  @doc("List Messages in specified conversation")
  listDataAssets is ResourceList<
    MessageDataAsset,
    QueryParametersTrait<WithQueryCreatedSince>
  >;
}
