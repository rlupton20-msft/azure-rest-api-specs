import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "../Science.Shared/all.tsp";
import "../Science.Management.Shared/all.tsp";
import "./_knowledgeBase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Microsoft.Science.Shared;

@versioned(Microsoft.Science.Bookshelf.Versions)
namespace Microsoft.Science.Bookshelf;

@doc("A version.")
@resource("versions")
@parentResource(KnowledgeBase)
model KnowledgeBaseVersion {
  @doc("The version name.")
  @visibility(Lifecycle.Read)
  @key("versionName")
  name: string;

  ...BaseKnowledgeBase;
}

@doc("Node pool identifier")
model WithNodePool {
  @doc("Node pool ID")
  nodePoolId: string;
}

@doc("Supercomputer run ID")
model WithRunId {
  @doc("Run ID")
  runId: string;
}

interface KnowledgeBaseVersions {
  @doc("Creates or replaces a KnowledgeBaseVersion.")
  createOrReplaceKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrReplace<KnowledgeBaseVersion>;

  @doc("Creates or updates a KnowledgeBaseVersion.")
  createOrUpdateKnowledgeBaseVersion is StandardResourceOperations.ResourceCreateOrUpdate<KnowledgeBaseVersion>;

  @doc("Fetch a KnowledgeBaseVersion by name.")
  getKnowledgeBaseVersion is ResourceRead<KnowledgeBaseVersion>;

  @doc("List KnowledgeBaseVersion resources")
  listKnowledgeBaseVersions is ResourceList<
    KnowledgeBaseVersion,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  getIndexingOperationStatus is Operations.GetResourceOperationStatus<
    KnowledgeBaseVersion,
    WithRunId
  >;

  @doc("Start indexing.")
  @pollingOperation(KnowledgeBaseVersions.getIndexingOperationStatus)
  startIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Stop indexing.")
  @pollingOperation(KnowledgeBaseVersions.getIndexingOperationStatus)
  stopIndexing is Operations.LongRunningResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  @doc("Delete a KnowledgeBaseVersion.")
  //  @pollingOperation(KnowledgeBaseVersions.getOperationStatus)
  deleteKnowledgeBaseVersion is ResourceDelete<KnowledgeBaseVersion>;

  //  @doc("Restore the KnowledgeBase to the state of this version.")
  //  restore is Operations.ResourceAction<KnowledgeBaseVersion, {}, KnowledgeBase>;
}
