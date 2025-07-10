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

@doc("ModelDefinition attributes from definitionContents")
model ModelDefinitionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithDocs;
  ...WithRepo;
}

@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinition {
  @doc("The model name.")
  @visibility(Lifecycle.Read)
  @key("modelName")
  name: string;

  ...Artifact<ModelDefinitionAttributes>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinitionWithYaml extends ModelDefinition {
  ...WithDefinitionContents;
}

interface ModelDefinitions {
  @doc("Fetch a ModelDefinition by name.")
  getModelDefinition is ResourceRead<ModelDefinition>;

  @doc("Creates a ModelDefinition.")
  createOrReplaceModelDefinition is StandardResourceOperations.ResourceCreateOrReplace<ModelDefinitionWithYaml>;

  @doc("Updates ModelDefinition.")
  createOrUpdateModelDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ModelDefinitionWithYaml>;

  @doc("List ModelDefinition resources within Catalog.")
  listModelDefinitions is ResourceList<ModelDefinition>;

  @doc("Delete a ModelDefinition.")
  deleteModelDefinition is ResourceDelete<ModelDefinition>;
}
