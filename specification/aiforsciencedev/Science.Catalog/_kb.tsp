import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_catalog.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("KnowledgeBase attributes from definitionContents")
model KnowledgeBaseAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithCopilotInstruction;
  ...WithInfraType;
  ...WithVersion;
}

@doc("A base knowledgeBase.")
model BaseKnowledgeBase {
  ...Artifact<KnowledgeBaseAttributes>;
}

@doc("A knowledgeBase.")
@parentResource(Catalog)
@resource("knowledgeBases")
model KnowledgeBase {
  @doc("The knowledgeBase name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;

  ...BaseKnowledgeBase;
}

@doc("A knowledgeBase.")
@parentResource(Catalog)
@resource("knowledgeBases")
model KnowledgeBaseWithYaml {
  @doc("The knowledgeBase name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;

  ...BaseKnowledgeBase;
  ...WithDefinitionContents;
}

interface KnowledgeBases {
  @doc("Fetch KnowledgeBase by name.")
  getKnowledgeBase is ResourceRead<KnowledgeBase>;

  @doc("Creates a KnowledgeBase.")
  createOrReplaceKnowledgeBase is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseWithYaml>;

  @doc("Updates KnowledgeBase.")
  createOrUpdateKnowledgeBase is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseWithYaml>;

  @doc("List KnowledgeBase resources")
  listKnowledgeBases is ResourceList<KnowledgeBase>;

  @doc("Delete KnowledgeBase.")
  deleteKnowledgeBase is ResourceDelete<KnowledgeBase>;
}
