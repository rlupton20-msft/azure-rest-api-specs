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

@doc("Extension attributes from definitionContents")
model ExtensionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithInfraType;

  @doc("Input data")
  @visibility("read")
  inputData: string;
}

@doc("A base extension.")
model BaseExtension {
  ...Artifact<ExtensionAttributes>;
}

@doc("A extension.")
@parentResource(Catalog)
@resource("extensions")
model Extension {
  @doc("The extension name.")
  @visibility("read")
  @key("extensionName")
  name: string;

  ...BaseExtension;
}

interface Extensions {
  @doc("Fetch Extension by name.")
  getExtension is ResourceRead<Extension>;

  @doc("Creates an Extension.")
  createOrReplaceExtension is StandardResourceOperations.ResourceCreateOrReplace<Extension &
    WithDefinitionContents>;

  @doc("Update Extension.")
  createOrUpdateExtension is StandardResourceOperations.ResourceCreateOrUpdate<Extension &
    WithDefinitionContents>;

  @doc("List Extensions")
  listExtensions is ResourceList<Extension>;

  @doc("Delete Extension.")
  deleteExtension is ResourceDelete<Extension>;
}
