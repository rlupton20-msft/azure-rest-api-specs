import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_tool.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A tool version.")
@parentResource(Tool)
@resource("versions")
model ToolVersion {
  @doc("The tool version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseTool;
}

interface ToolVersions {
  @doc("Fetch a ToolVersion by name.")
  getToolVersion is ResourceRead<ToolVersion>;

  @doc("Creates a Tool.")
  createOrReplaceToolVersion is StandardResourceOperations.ResourceCreateOrReplace<ToolVersion>;

  //  @doc("Updates Tool.")
  //  createOrUpdateToolVersion is StandardResourceOperations.ResourceCreateOrUpdate<ToolVersion>;

  @doc("List Tool resources")
  listToolVersions is ResourceList<ToolVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ToolVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
