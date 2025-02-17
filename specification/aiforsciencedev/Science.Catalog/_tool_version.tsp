import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A tool version.")
@parentResource(ToolDefinition)
@resource("versions")
model ToolDefinitionVersion {
  @doc("The tool version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseToolDefinition;
}

@doc("A tool version.")
@parentResource(ToolDefinition)
@resource("versions")
model ToolDefinitionVersionWithYaml {
  @doc("The tool version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseToolDefinition;
  ...WithDefinitionContents;
}

interface ToolDefinitionVersions {
  @doc("Fetch a ToolDefinitionVersion by name.")
  getToolDefinitionVersion is ResourceRead<ToolDefinitionVersion>;

  //  @doc("Creates a ToolDefinition.")
  //  createOrReplaceToolDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<ToolDefinitionVersionWithYaml>;

  @doc("Updates ToolDefinition.")
  createOrUpdateToolDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<ToolDefinitionVersionWithYaml>;

  @doc("List ToolDefinition resources")
  listToolDefinitionVersions is ResourceList<ToolDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ToolDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
