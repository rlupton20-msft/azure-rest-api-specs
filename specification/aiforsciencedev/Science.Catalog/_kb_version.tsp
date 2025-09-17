import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_kb.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A knowledgeBase version.")
@parentResource(KnowledgeBaseDefinition)
@resource("versions")
model KnowledgeBaseDefinitionVersion {
  @doc("The knowledgeBase version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseKnowledgeBaseDefinition;
}

@doc("A knowledgeBase version.")
@parentResource(KnowledgeBaseDefinition)
@resource("versions")
model KnowledgeBaseDefinitionVersionWithYaml {
  @doc("The knowledgeBase version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseKnowledgeBaseDefinition;
  ...WithDefinitionContents;
}

interface KnowledgeBaseDefinitionVersions {
  @doc("Fetch a KnowledgeBaseDefinitionVersion by name.")
  getKnowledgeBaseDefinitionVersion is ResourceRead<KnowledgeBaseDefinitionVersion>;

  @doc("Creates a KnowledgeBaseDefinition.")
  createOrReplaceKnowledgeBaseDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseDefinitionVersionWithYaml>;

  @doc("Updates KnowledgeBaseDefinition.")
  createOrUpdateKnowledgeBaseDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseDefinitionVersionWithYaml>;

  @doc("List KnowledgeBaseDefinition resources")
  listKnowledgeBaseDefinitionVersions is ResourceList<KnowledgeBaseDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    KnowledgeBaseDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
