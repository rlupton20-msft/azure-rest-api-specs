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

@versioned(Microsoft.Discovery.Catalog.Versions)
namespace Microsoft.Discovery.Catalog;

@doc("A knowledgeBase Definition.")
@parentResource(Catalog)
@resource("knowledgeBaseDefinitions")
model KnowledgeBaseDefinition {
  @doc("The knowledgeBase name.")
  @visibility(Lifecycle.Read)
  @key("knowledgeBaseName")
  @pattern(Microsoft.Discovery.Shared.resourceNamePattern)
  name: string;

  ...WithVersion;
  ...Artifact;
  ...WithCategory;
  ...WithLicense;
  ...WithCopilotInstruction;
  ...WithInfraType;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("A knowledgeBase Definition.")
@parentResource(Catalog)
@resource("knowledgeBaseDefinitions")
model KnowledgeBaseDefinitionWithContent extends KnowledgeBaseDefinition {
  ...WithDefinitionContents;
}

interface KnowledgeBaseDefinitions {
  @doc("Fetch KnowledgeBaseDefinition by name.")
  getKnowledgeBaseDefinition is ResourceRead<KnowledgeBaseDefinitionWithContent>;

  @doc("Creates or updates KnowledgeBaseDefinition.")
  createOrUpdateKnowledgeBaseDefinition is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseDefinitionWithContent>;

  @doc("List KnowledgeBaseDefinition resources within Catalog.")
  listKnowledgeBaseDefinitions is ResourceList<KnowledgeBaseDefinition>;

  @doc("Delete KnowledgeBaseDefinition.")
  deleteKnowledgeBaseDefinition is ResourceDelete<KnowledgeBaseDefinition>;
}
