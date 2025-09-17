import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_dataAsset.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.Science.Catalog.Versions)
namespace Microsoft.Science.Catalog;

@doc("A dataAsset version.")
@parentResource(DataAssetDefinition)
@resource("versions")
model DataAssetDefinitionVersion {
  @doc("The dataAsset version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseDataAssetDefinition;
}

@doc("A dataAsset version.")
@parentResource(DataAssetDefinition)
@resource("versions")
model DataAssetDefinitionVersionWithYaml {
  @doc("The dataAsset version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseDataAssetDefinition;
  ...WithDefinitionContents;
}

interface DataAssetDefinitionVersions {
  @doc("Fetch a DataAssetDefinitionVersion by name.")
  getDataAssetDefinitionVersion is ResourceRead<DataAssetDefinitionVersion>;

  //    @doc("Creates a DataAssetDefinition.")
  //    createOrReplaceDataAssetDefinitionVersion is StandardResourceOperations.ResourceCreateOrReplace<DataAssetDefinitionVersionWithYaml>;

  @doc("Updates DataAssetDefinition.")
  createOrUpdateDataAssetDefinitionVersion is StandardResourceOperations.ResourceCreateOrUpdate<DataAssetDefinitionVersionWithYaml>;

  @doc("List DataAssetDefinition resources")
  listDataAssetDefinitionVersions is ResourceList<DataAssetDefinitionVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    DataAssetDefinitionVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
