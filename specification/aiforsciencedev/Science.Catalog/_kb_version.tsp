import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_kb.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("A knowledgeBase version.")
@parentResource(KnowledgeBase)
@resource("versions")
model KnowledgeBaseVersion {
  @doc("The knowledgeBase version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseKnowledgeBase;
}

@doc("A knowledgeBase version.")
@parentResource(KnowledgeBase)
@resource("versions")
model KnowledgeBaseVersionWithYaml {
  @doc("The knowledgeBase version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseKnowledgeBase;
  ...WithDefinitionContents;
}

interface KnowledgeBaseVersions {
  @doc("Fetch a KnowledgeBaseVersion by name.")
  getKnowledgeBaseVersion is ResourceRead<KnowledgeBaseVersion>;

  @doc("Creates a KnowledgeBase.")
  createOrReplaceKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseVersionWithYaml>;

  @doc("Updates KnowledgeBase.")
  createOrUpdateKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseVersionWithYaml>;

  @doc("List KnowledgeBase resources")
  listKnowledgeBaseVersions is ResourceList<KnowledgeBaseVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    KnowledgeBaseVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
