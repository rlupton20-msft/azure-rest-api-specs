import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Discovery.Shared/data-plane.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Microsoft.Discovery.Shared;

@versioned(Microsoft.Discovery.Bookshelf.Versions)
namespace Microsoft.Discovery.Bookshelf;

/** Enum for IndexingStatus */
@lroStatus
union IndexingStatus {
  /** Indexing Not started */
  NotStarted: "NotStarted",

  /** Running */
  Running: "Running",

  /** Succeeded */
  @lroSucceeded
  Succeeded: "Succeeded",

  /** Canceled */
  @lroCanceled
  Canceled: "Canceled",

  /** Failed */
  @lroFailed
  Failed: "Failed",

  string,
}

@doc("A knowledgeBase.")
model BaseKnowledgeBase {
  ...WithId;

  @doc("Version.")
  @visibility(Lifecycle.Read)
  version: string;

  /** The ame of the associated Bookshelf tracked resource. */
  @visibility(Lifecycle.Read)
  bookshelfName: string;

  @doc("Catalog data assets to index.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  dataAssetIds: DataAssetId[];

  @doc("URL to access the knowledge base.")
  @visibility(Lifecycle.Read)
  // TODO: Should this be in KnowledgeBaseDefinition?
  knowledgeBaseUrl?: string;

  ...DataPlaneResource;
  ...WithTags;
  ...WithDescription;
  ...WithCopilotInstruction;
  ...WithStatus<IndexingStatus>;
}

@doc("A knowledgeBase.")
@resource("knowledgeBases")
model KnowledgeBase {
  @doc("The knowledgeBase name.")
  @visibility(Lifecycle.Read)
  @key("knowledgeBaseName")
  @pattern(Microsoft.Discovery.Shared.resourceNamePattern)
  name: string;

  ...BaseKnowledgeBase;
}

interface KnowledgeBases {
  @doc("List KnowledgeBase resources")
  listKnowledgeBases is ResourceList<KnowledgeBase>;

  @doc("Delete a KnowledgeBase.")
  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  deleteKnowledgeBase is LongRunningResourceDelete<KnowledgeBase>;
}
