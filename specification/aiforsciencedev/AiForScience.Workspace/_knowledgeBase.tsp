import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

/** Enum for IndexingStatus */
union IndexingStatus {
  /** Not started */
  NotStarted: "NotStarted",

  /** Processing: Formerly Started */
  // TODO: Consider "Indexing"", "Processing" or other verb ending in "ing" to indicate transient/non-terminal.
  Processing: "Processing",

  /** Completed */
  Completed: "Completed",

  /** Failed */
  Failed: "Failed ",

  string,
}

@doc("Input Catalogs referenced by KnowledgeBase")
model InputCatalogs {
  ...ResourceReference;

  /** Data assets */
  dataAssetIds: string[];
}

@doc("A knowledgeBase.")
model BaseKnowledgeBase {
  ...WithId;
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithStatus<IndexingStatus>;

  @doc("Input catalogs to index.")
  @visibility("read", "create")
  dataAssets: ResourceReference[];

  @doc("URL to access the knowledge base.")
  @visibility("read")
  knowledgeBaseUrl?: string;

  @doc("Version.")
  @visibility("read")
  version: string;
}

@doc("A knowledgeBase.")
@resource("knowledgeBases")
model KnowledgeBase {
  ...BaseKnowledgeBase;

  @doc("The knowledgeBase name.")
  @visibility("read")
  @key("knowledgeBaseName")
  name: string;
}

interface KnowledgeBases {
  @doc("List KnowledgeBase resources")
  listKnowledgeBases is ResourceList<KnowledgeBase>;

  //  getOperationStatus is Operations.GetResourceOperationStatus<
  //    KnowledgeBase,
  //    never
  //  >;

  @doc("Delete a KnowledgeBase.")
  //  @pollingOperation(KnowledgeBases.getOperationStatus)
  deleteKnowledgeBase is ResourceDelete<KnowledgeBase>;
}
