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
@parentResource(Extension)
@resource("versions")
model ExtensionVersion {
  @doc("The extension version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseExtension;
}

interface ExtensionVersions {
  @doc("Fetch a ExtensionVersion by name.")
  getExtensionVersion is ResourceRead<ExtensionVersion>;

  //  @doc("Creates a Extension.")
  //  createOrReplaceExtensionVersion is StandardResourceOperations.ResourceCreateOrReplace<ExtensionVersion>;

  @doc("Updates Extension.")
  createOrUpdateExtensionVersion is StandardResourceOperations.ResourceCreateOrUpdate<ExtensionVersion>;

  @doc("List Extension resources")
  listExtensionVersions is ResourceList<ExtensionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ExtensionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
