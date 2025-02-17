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

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("KnowledgeBaseDefinition attributes from definitionContents")
model KnowledgeBaseDefinitionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithCopilotInstruction;
  ...WithInfraType;
  ...WithVersion;
}

@doc("A base knowledgeBase.")
model BaseKnowledgeBaseDefinition {
  ...Artifact<KnowledgeBaseDefinitionAttributes>;
}

@doc("A knowledgeBase.")
@parentResource(Catalog)
@resource("knowledgeBaseDefinitions")
model KnowledgeBaseDefinition {
  @doc("The knowledgeBase name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;

  ...BaseKnowledgeBaseDefinition;
}

@doc("A knowledgeBase.")
@parentResource(Catalog)
@resource("knowledgeBaseDefinitions")
model KnowledgeBaseDefinitionWithYaml {
  @doc("The knowledgeBase name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;

  ...BaseKnowledgeBaseDefinition;
  ...WithDefinitionContents;
}

interface KnowledgeBaseDefinitions {
  @doc("Fetch KnowledgeBaseDefinition by name.")
  getKnowledgeBaseDefinition is ResourceRead<KnowledgeBaseDefinition>;

  @doc("Creates a KnowledgeBaseDefinition.")
  createOrReplaceKnowledgeBaseDefinition is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseDefinitionWithYaml>;

  @doc("Updates KnowledgeBaseDefinition.")
  createOrUpdateKnowledgeBaseDefinition is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseDefinitionWithYaml>;

  @doc("List KnowledgeBaseDefinition resources")
  listKnowledgeBaseDefinitions is ResourceList<KnowledgeBaseDefinition>;

  @doc("Delete KnowledgeBaseDefinition.")
  deleteKnowledgeBaseDefinition is ResourceDelete<KnowledgeBaseDefinition>;
}
