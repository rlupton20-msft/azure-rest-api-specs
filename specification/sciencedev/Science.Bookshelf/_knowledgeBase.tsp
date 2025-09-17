import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Science.Shared/all.tsp";
import "../Science.Management.Shared/all.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Science.Shared;

@versioned(Microsoft.Science.Bookshelf.Versions)
namespace Microsoft.Science.Bookshelf;

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

@doc("A knowledgeBase.")
model BaseKnowledgeBase {
  ...DataPlaneResource;
  ...WithTags;
  ...WithDescription;
  ...WithStatus<IndexingStatus>;

  @doc("Catalog data assets to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dataAssetIds: DataAssetId[];

  @doc("URL to access the knowledge base.")
  @visibility(Lifecycle.Read)
  // TODO: is thus the data plane API?
  knowledgeBaseUrl?: string;

  @doc("Version.")
  @visibility(Lifecycle.Read)
  version: string;
}

@doc("A knowledgeBase.")
@resource("knowledgeBases")
model KnowledgeBase {
  ...BaseKnowledgeBase;

  @doc("The knowledgeBase name.")
  @visibility(Lifecycle.Read)
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
