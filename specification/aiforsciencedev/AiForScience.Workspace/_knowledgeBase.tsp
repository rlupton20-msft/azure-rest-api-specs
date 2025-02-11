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
  dataAssets: ResourceReference[];
}

@doc("A knowledgeBase.")
model BaseKnowledgeBase {
  ...WithId;
  ...WithTitle;
  ...WithTags;
  ...WithCreatedAt;
  ...WithUpdatedAt;
  ...WithStatus<IndexingStatus>;

  //  ...WithDescription;

  // Using WithStatus<IndexingStatus> instead for conformity.
  //  @doc("Indexing status.")
  //  @visibility("read")
  //  indexingStatus: IndexingStatus;

  @doc("Input catalogs to index.")
  @visibility("read", "create")
  inputCatalogs: InputCatalogs;

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
  //  @doc("Fetch a KnowledgeBase by name.")
  //  getKnowledgeBase is ResourceRead<KnowledgeBase>;

  @doc("Creates or replaces a KnowledgeBase.")
  createOrReplaceKnowledgeBase is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBase>;

  @doc("Creates or updates a KnowledgeBase.")
  createOrUpdateKnowledgeBase is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBase>;

  @doc("List KnowledgeBase resources")
  listKnowledgeBases is ResourceList<KnowledgeBase>;

  //  @doc("Clone KnowledgeBase (to a new one).")
  //  clone is Operations.ResourceAction<KnowledgeBase, {}, KnowledgeBase>;
}
