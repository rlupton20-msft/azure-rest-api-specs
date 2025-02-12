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

@doc("ExtensionDefinition attributes from definitionContents")
model ExtensionDefinitionAttributes {
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
model BaseExtensionDefinition {
  ...Artifact<ExtensionDefinitionAttributes>;
}

@doc("A extension.")
@parentResource(Catalog)
@resource("extensionDefinitions")
model ExtensionDefinition {
  @doc("The extension name.")
  @visibility("read")
  @key("extensionName")
  name: string;

  ...BaseExtensionDefinition;
}

@doc("A extension.")
@parentResource(Catalog)
@resource("extensionDefinitions")
model ExtensionDefinitionWithYaml {
  @doc("The extension name.")
  @visibility("read")
  @key("extensionName")
  name: string;

  ...BaseExtensionDefinition;
  ...WithDefinitionContents;
}

interface ExtensionDefinitions {
  @doc("Fetch ExtensionDefinition by name.")
  getExtensionDefinition is ResourceRead<ExtensionDefinition>;

  @doc("Creates an ExtensionDefinition.")
  createOrReplaceExtensionDefinition is StandardResourceOperations.ResourceCreateOrReplace<ExtensionDefinitionWithYaml>;

  @doc("Update ExtensionDefinition.")
  createOrUpdateExtensionDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ExtensionDefinitionWithYaml>;

  @doc("List ExtensionDefinitions")
  listExtensionDefinitions is ResourceList<ExtensionDefinition>;

  @doc("Delete ExtensionDefinition.")
  deleteExtensionDefinition is ResourceDelete<ExtensionDefinition>;
}
