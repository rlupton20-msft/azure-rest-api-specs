import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./_agent.tsp";
import "./_tool.tsp";
import "./_dataAsset.tsp";
import "./_kb.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A catalog agent definition.")
@resource("agentDefinitions")
model AgentDefinitionAnyCatalog {
  ...BaseAgentDefinition;

  @doc("The agent name.")
  @visibility("read")
  @key("agentName")
  name: string;
}

@doc("A catalog model.")
@resource("modelDefinitions")
model ModelDefinitionAnyCatalog {
  ...BaseModelDefinition;

  @doc("The model name.")
  @visibility("read")
  @key("modelName")
  name: string;
}

@doc("A catalog tool.")
@resource("toolDefinitions")
model ToolDefinitionAnyCatalog {
  ...BaseToolDefinition;

  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;
}

@doc("A catalog data asset.")
@resource("dataAssetDefinitions")
model DataAssetsDefinitionAnyCatalog {
  ...BaseDataAssetDefinition;

  @doc("The data asset name.")
  @visibility("read")
  @key("dataAssetName")
  name: string;
}

@doc("A catalog knowledge base.")
@resource("knowledgeBaseDefinitions")
model KnowledgeBaseDefinitionAnyCatalog {
  ...BaseKnowledgeBaseDefinition;

  @doc("The asset name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;
}

@route("/")
interface Root {
  @doc("Retrieve a list of agents for all catalogs.")
  listAgentDefinitions is Operations.ResourceList<
    AgentDefinitionAnyCatalog,
    AgentDefinitionAnyCatalog
  >;

  @doc("Retrieve a list of models for all catalogs.")
  listModelDefinitions is Operations.ResourceList<
    ModelDefinitionAnyCatalog,
    ModelDefinitionAnyCatalog
  >;

  @doc("Retrieve a list of tools for all catalogs.")
  listToolDefinitions is Operations.ResourceList<
    ToolDefinitionAnyCatalog,
    ToolDefinitionAnyCatalog
  >;

  @doc("Retrieve a list of data assets for all catalogs.")
  listDataAssetDefinitions is Operations.ResourceList<
    DataAssetsDefinitionAnyCatalog,
    DataAssetsDefinitionAnyCatalog
  >;

  @doc("Retrieve a list of knowledge bases for all catalogs.")
  listKnowledgeBaseDefinitions is Operations.ResourceList<
    KnowledgeBaseDefinitionAnyCatalog,
    KnowledgeBaseDefinitionAnyCatalog
  >;
}
