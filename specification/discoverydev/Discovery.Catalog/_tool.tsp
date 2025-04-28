import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_catalog.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(Microsoft.Discovery.Catalog.Versions)
namespace Microsoft.Discovery.Catalog;

@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinition {
  @doc("The tool name.")
  @visibility(Lifecycle.Read)
  @key("toolName")
  @pattern(Microsoft.Discovery.Shared.resourceNamePattern)
  name: string;

  ...Artifact;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithDocs;
  ...WithRepo;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinitionWithContent extends ToolDefinition {
  ...WithDefinitionContents;
}

interface ToolDefinitions {
  @doc("Fetch a ToolDefinition by name.")
  getToolDefinition is ResourceRead<ToolDefinitionWithContent>;

  @doc("Create or update a ToolDefinition.")
  createOrUpdateToolDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ToolDefinitionWithContent>;

  @doc("List ToolDefinition resources within Catalog.")
  listToolDefinitions is ResourceList<ToolDefinition>;

  @doc("Delete a ToolDefinition.")
  deleteToolDefinition is ResourceDelete<ToolDefinition>;
}
