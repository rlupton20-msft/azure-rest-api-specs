import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";
import "./_catalog.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@versioned(Microsoft.Discovery.Catalog.Versions)
namespace Microsoft.Discovery.Catalog;

@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinition {
  @doc("The model name.")
  @visibility(Lifecycle.Read)
  @key("modelName")
  @pattern(Microsoft.Discovery.Shared.resourceNamePattern)
  name: string;

  ...Artifact;
  ...WithCategory;
  ...WithLicense;
  ...WithVersion;
  ...WithDocs;
  ...WithRepo;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance"
// Inheritance is appropriate here
@doc("A model.")
@parentResource(Catalog)
@resource("modelDefinitions")
model ModelDefinitionWithContent extends ModelDefinition {
  ...WithDefinitionContents;
}

interface ModelDefinitions {
  @doc("Fetch a ModelDefinition by name.")
  getModelDefinition is ResourceRead<ModelDefinitionWithContent>;

  @doc("Creates or updates ModelDefinition.")
  createOrUpdateModelDefinition is StandardResourceOperations.ResourceCreateOrUpdate<ModelDefinitionWithContent>;

  @doc("List ModelDefinition resources within Catalog.")
  listModelDefinitions is ResourceList<ModelDefinition>;

  @doc("Delete a ModelDefinition.")
  deleteModelDefinition is ResourceDelete<ModelDefinition>;
}
