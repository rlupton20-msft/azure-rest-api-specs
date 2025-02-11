import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_kb.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

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

interface KnowledgeBaseVersions {
  @doc("Fetch a KnowledgeBaseVersion by name.")
  getKnowledgeBaseVersion is ResourceRead<KnowledgeBaseVersion>;

  //  @doc("Creates a KnowledgeBase.")
  //  createOrReplaceKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseVersion>;

  @doc("Updates KnowledgeBase.")
  createOrUpdateKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseVersion>;

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
