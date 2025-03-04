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

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("ToolDefinition attributes from definitionContents")
model ToolDefinitionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithDocs;
  ...WithRepo;
}

@doc("A base tool.")
model BaseToolDefinition {
  ...Artifact<ToolDefinitionAttributes>;
}

@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinition {
  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;

  ...BaseToolDefinition;
}

@doc("A tool.")
@parentResource(Catalog)
@resource("toolDefinitions")
model ToolDefinitionWithYaml {
  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;

  ...BaseToolDefinition;
  ...WithDefinitionContents;
}

interface ToolDefinitions {
  @doc("Fetch a ToolDefinition by name.")
  getToolDefinition is ResourceRead<ToolDefinition>;

  @doc("Creates a ToolDefinition.")
  createOrReplaceToolDefinition is StandardResourceOperations.ResourceCreateOrReplace<ToolDefinitionWithYaml>;

  @doc("Update a ToolDefinition.")
  createOrUpdateToolDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ToolDefinitionWithYaml>;

  //    @doc("Create using Yaml definition.")
  //    createWithDefinitionYaml is Operations.ResourceAction<
  //      ToolDefinition,
  //      BaseToolDefinition & WithDefinitionContents,
  //      ToolDefinition
  //    >;
  //
  //    @doc("Update Yaml definition.")
  //    updateWithDefinitionYaml is Operations.ResourceAction<
  //      ToolDefinition,
  //      WithTags & WithDefinitionContents,
  //      ToolDefinition
  //    >;

  @doc("List ToolDefinition resources")
  listToolDefinitions is ResourceList<ToolDefinition>;

  @doc("Delete a ToolDefinition.")
  deleteToolDefinition is ResourceDelete<ToolDefinition>;
}
