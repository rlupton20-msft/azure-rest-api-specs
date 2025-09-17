import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A model version.")
@parentResource(ModelDefinition)
@resource("versions")
model ModelDefinitionVersion {
  @doc("The model version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseModelDefinition;
}

@doc("A model version.")
@parentResource(ModelDefinition)
@resource("versions")
model ModelDefinitionVersionWithYaml {
  @doc("The model version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseModelDefinition;
  ...WithDefinitionContents;
}

interface ModelDefinitionVersions {
  @doc("Fetch a ModelDefinitionVersion by name.")
  getModelDefinitionVersion is ResourceRead<ModelDefinitionVersion>;

  //  @doc("Creates a ModelDefinition.")
  //  createOrReplaceModelDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<ModelDefinitionVersionWithYaml>;

  @doc("Updates ModelDefinition.")
  createOrUpdateModelDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<ModelDefinitionVersionWithYaml>;

  @doc("List ModelDefinition resources")
  listModelDefinitionVersions is ResourceList<ModelDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ModelDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
