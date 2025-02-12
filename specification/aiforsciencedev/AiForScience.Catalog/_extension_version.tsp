import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_extension.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A extension version.")
@parentResource(ExtensionDefinition)
@resource("versions")
model ExtensionDefinitionVersion {
  @doc("The extension version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseExtensionDefinition;
}

@doc("A extension version.")
@parentResource(ExtensionDefinition)
@resource("versions")
model ExtensionDefinitionVersionWithYaml {
  @doc("The extension version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseExtensionDefinition;
  ...WithDefinitionContents;
}

interface ExtensionDefinitionVersions {
  @doc("Fetch a ExtensionDefinitionVersion by name.")
  getExtensionDefinitionVersion is ResourceRead<ExtensionDefinitionVersion>;

  //    @doc("Creates a ExtensionDefinition.")
  //    createOrReplaceExtensionDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<ExtensionDefinitionVersionWithYaml>;

  @doc("Updates ExtensionDefinition.")
  createOrUpdateExtensionDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<ExtensionDefinitionVersionWithYaml>;

  @doc("List ExtensionDefinition resources")
  listExtensionDefinitionVersions is ResourceList<ExtensionDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ExtensionDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
