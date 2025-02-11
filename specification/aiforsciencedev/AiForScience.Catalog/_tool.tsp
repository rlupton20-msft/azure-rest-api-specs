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

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("Tool attributes from definitionContents")
model ToolAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;

  @doc("A tool docs URI.")
  @visibility("read")
  toolDocs: string;

  @doc("A tool repo URI.")
  @visibility("read")
  toolRepo: string;
}

@doc("A base tool.")
model BaseTool {
  ...Artifact<ToolAttributes>;
}

@doc("A tool.")
@parentResource(Catalog)
@resource("tools")
model Tool {
  @doc("The tool name.")
  @visibility("read")
  @key("toolName")
  name: string;

  ...BaseTool;
  //  ...WithDefinitionContents;
}

interface Tools {
  @doc("Fetch a Tool by name.")
  getTool is ResourceRead<Tool>;

  @doc("Creates a Tool.")
  createOrReplaceTool is StandardResourceOperations.ResourceCreateOrReplace<Tool &
    WithDefinitionContents>;

  //    @doc("Create using Yaml definition.")
  //    createWithDefinitionYaml is Operations.ResourceAction<
  //      Tool,
  //      BaseTool & WithDefinitionContents,
  //      Tool
  //    >;
  //
  //    @doc("Update Yaml definition.")
  //    updateWithDefinitionYaml is Operations.ResourceAction<
  //      Tool,
  //      WithTags & WithDefinitionContents,
  //      Tool
  //    >;

  @doc("Update Tool.")
  createOrUpdateTool is StandardResourceOperations.ResourceCreateOrUpdate<Tool &
    WithDefinitionContents>;

  @doc("List Tool resources")
  listTools is ResourceList<Tool>;

  @doc("Delete a Tool.")
  deleteTool is ResourceDelete<Tool>;
}
