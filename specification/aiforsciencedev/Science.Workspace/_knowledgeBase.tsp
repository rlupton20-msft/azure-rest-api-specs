import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Workspace.Versions)
namespace Microsoft.Science.Workspace;

/** Enum for IndexingStatus */
union IndexingStatus {
  /** Indexing Not started */
  NotStarted: "NotStarted",

  /** Indexing Processing: Formerly Started */
  // TODO: Consider "Indexing"", "Processing" or other verb ending in "ing" to indicate transient/non-terminal.
  Processing: "Processing",

  /** Indexing Completed */
  Completed: "Completed",

  /** Indexing Stopped */
  Stopped: "Stopped ",

  /** Indexing Failed */
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
  @doc("Fetch a KnowledgeBase by name. Gets latest version.")
  getKnowledgeBase is ResourceRead<KnowledgeBase>;

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
