import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./_agent.tsp";
import "./_tool.tsp";
import "./_dataAsset.tsp";
import "./_extension.tsp";
import "./_kb.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A catalog agent.")
@resource("agents")
model AgentAnyCatalog {
  ...BaseAgent;

  @doc("The agent name.")
  @visibility("read")
  @key("agentName")
  name: string;
}

@doc("A catalog model.")
@resource("models")
model ModelAnyCatalog {
  ...BaseModel;

  @doc("The model name.")
  @visibility("read")
  @key("modelName")
  name: string;
}

@doc("A catalog tool.")
@resource("tools")
model ToolAnyCatalog {
  ...BaseTool;

  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;
}

@doc("A catalog data asset.")
@resource("dataAssets")
model DataAssetsAnyCatalog {
  ...BaseDataAsset;

  @doc("The data asset name.")
  @visibility("read")
  @key("dataAssetName")
  name: string;
}

@doc("A catalog extension.")
@resource("extensions")
model ExtensionAnyCatalog {
  ...BaseExtension;

  @doc("The asset name.")
  @visibility("read")
  @key("extensionName")
  name: string;
}

@doc("A catalog knowledge base.")
@resource("knowledgeBases")
model KnowledgeBaseAnyCatalog {
  ...BaseKnowledgeBase;

  @doc("The asset name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;
}

@route("/")
interface Root {
  @doc("Retrieve a list of agents for all catalogs.")
  listAgents is Operations.ResourceList<AgentAnyCatalog, AgentAnyCatalog>;

  @doc("Retrieve a list of models for all catalogs.")
  listModels is Operations.ResourceList<ModelAnyCatalog, ModelAnyCatalog>;

  @doc("Retrieve a list of tools for all catalogs.")
  listTools is Operations.ResourceList<ToolAnyCatalog, ToolAnyCatalog>;

  @doc("Retrieve a list of data assets for all catalogs.")
  listDataAssets is Operations.ResourceList<
    DataAssetsAnyCatalog,
    DataAssetsAnyCatalog
  >;

  @doc("Retrieve a list of extensions for all catalogs.")
  listExtensions is Operations.ResourceList<
    ExtensionAnyCatalog,
    ExtensionAnyCatalog
  >;

  @doc("Retrieve a list of knowledge bases for all catalogs.")
  listKnowledgeBases is Operations.ResourceList<
    KnowledgeBaseAnyCatalog,
    KnowledgeBaseAnyCatalog
  >;
}
