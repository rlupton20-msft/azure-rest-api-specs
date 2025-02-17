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

  @doc("A model docs URI.")
  @visibility("read")
  modelDocs: string;

  @doc("A model repo URI.")
  @visibility("read")
  modelRepo: string;
}

@doc("A base model.")
model BaseModelDefinition {
  ...Artifact<ModelDefinitionAttributes>;
}

@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinition {
  @doc("The model name.")
  @visibility("read")
  @key("modelName")
  name: string;

  ...BaseModelDefinition;
}

@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinitionWithYaml {
  @doc("The model name.")
  @visibility("read")
  @key("modelName")
  name: string;

  ...BaseModelDefinition;
  ...WithDefinitionContents;
}

interface ModelDefinitions {
  @doc("Fetch a ModelDefinition by name.")
  getModelDefinition is ResourceRead<ModelDefinition>;

  @doc("Creates a ModelDefinition.")
  createOrReplaceModelDefinition is StandardResourceOperations.ResourceCreateOrReplace<ModelDefinitionWithYaml>;

  @doc("Updates ModelDefinition.")
  createOrUpdateModelDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ModelDefinitionWithYaml>;

  @doc("List ModelDefinition resources")
  listModelDefinitions is ResourceList<ModelDefinition>;

  @doc("Delete a ModelDefinition.")
  deleteModelDefinition is ResourceDelete<ModelDefinition>;
}
