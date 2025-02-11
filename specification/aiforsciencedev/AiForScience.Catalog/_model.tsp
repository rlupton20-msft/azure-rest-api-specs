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

@doc("Model attributes from definitionContents")
model ModelAttributes {
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
model BaseModel {
  ...Artifact<ModelAttributes>;
}

@doc("A model.")
@parentResource(Catalog)
@resource("models")
model Model {
  @doc("The model name.")
  @visibility("read")
  @key("modelName")
  name: string;

  ...BaseModel;
  //  ...WithDefinitionContents;
}

interface Models {
  @doc("Fetch a Model by name.")
  getModel is ResourceRead<Model>;

  @doc("Creates a Model.")
  createOrReplaceModel is StandardResourceOperations.ResourceCreateOrReplace<Model &
    WithDefinitionContents>;

  @doc("Updates Model.")
  createOrUpdateModel is StandardResourceOperations.ResourceCreateOrUpdate<Model &
    WithDefinitionContents>;

  @doc("List Model resources")
  listModels is ResourceList<Model>;

  @doc("Delete a Model.")
  deleteModel is ResourceDelete<Model>;
}
