import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A model version.")
@parentResource(Model)
@resource("versions")
model ModelVersion {
  @doc("The model version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseModel;
}

interface ModelVersions {
  @doc("Fetch a ModelVersion by name.")
  getModelVersion is ResourceRead<ModelVersion>;

  @doc("Creates a Model.")
  createOrReplaceModelVersion is StandardResourceOperations.ResourceCreateOrReplace<ModelVersion>;

  //  @doc("Updates Model.")
  //  createOrUpdateModelVersion is StandardResourceOperations.ResourceCreateOrUpdate<ModelVersion>;

  @doc("List Model resources")
  listModelVersions is ResourceList<ModelVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    ModelVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
