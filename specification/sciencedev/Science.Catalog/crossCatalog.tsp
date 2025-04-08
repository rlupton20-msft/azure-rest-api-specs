import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

import "../Science.Shared/all.tsp";
import "./_agent.tsp";
import "./_kb.tsp";
import "./_model.tsp";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Microsoft.Science.Shared;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@route("/")
interface CrossCatalog {
  /** List T across catalogs */
  @get
  List<T extends {name: string}>(
    ...Azure.ResourceManager.ApiVersionParameter,
  ): Paged<T> | Azure.Core.Foundations.ErrorResponse;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List AgentDefinitions for all catalogs.")
  @route("/agentDefinitions")
  listAgentDefinitions is CrossCatalog.List<AgentDefinition>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List KnowledgeBaseDefinitions for all catalogs.")
  @route("/knowledgeBaseDefinitions")
  listKnowledgeBaseDefinitions is CrossCatalog.List<KnowledgeBaseDefinition>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List ModelDefinitions for all catalogs.")
  @route("/modelDefinitions")
  listModelDefinitions is CrossCatalog.List<ModelDefinition>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-names"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List ToolDefinitions for all catalogs.")
  @route("/toolDefinitions")
  listToolDefinitions is CrossCatalog.List<ToolDefinition>;
}
