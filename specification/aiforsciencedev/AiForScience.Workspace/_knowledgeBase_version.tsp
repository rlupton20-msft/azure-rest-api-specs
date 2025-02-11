import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.tsp";
import "./_knowledgeBase.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceWorkspace.Versions)
namespace Microsoft.AiForScienceWorkspace;

@doc("A version.")
@resource("versions")
@parentResource(KnowledgeBase)
model KnowledgeBaseVersion {
  @doc("The version name.")
  @visibility("read")
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
  @doc("Fetch a KnowledgeBaseVersion by name.")
  getKnowledgeBaseVersion is ResourceRead<KnowledgeBaseVersion>;

  @doc("List KnowledgeBaseVersion resources")
  listKnowledgeBaseVersions is ResourceList<
    KnowledgeBaseVersion,
    QueryParametersTrait<WithQueryCreatedSince>
  >;

  @doc("Start indexing.")
  startIndexing is Operations.ResourceAction<
    KnowledgeBaseVersion,
    WithNodePool,
    WithRunId
  >;

  //  @doc("Restore the KnowledgeBase to the state of this version.")
  //  restore is Operations.ResourceAction<KnowledgeBaseVersion, {}, KnowledgeBase>;
}
