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

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("ToolDefinition attributes from definitionContents")
model ToolDefinitionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithDocs;
  ...WithRepo;
}

@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinition {
  @doc("The tool name.")
  @visibility(Lifecycle.Read)
  @key("toolName")
  name: string;

  ...Artifact<ToolDefinitionAttributes>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinitionWithYaml extends ToolDefinition {
  ...WithDefinitionContents;
}

interface ToolDefinitions {
  @doc("Fetch a ToolDefinition by name.")
  getToolDefinition is ResourceRead<ToolDefinition>;

  @doc("Creates a ToolDefinition.")
  createOrReplaceToolDefinition is StandardResourceOperations.ResourceCreateOrReplace<ToolDefinitionWithYaml>;

  @doc("Update a ToolDefinition.")
  createOrUpdateToolDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ToolDefinitionWithYaml>;

  @doc("List ToolDefinition resources within Catalog.")
  listToolDefinitions is ResourceList<ToolDefinition>;

  @doc("Delete a ToolDefinition.")
  deleteToolDefinition is ResourceDelete<ToolDefinition>;
}
