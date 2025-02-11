import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./_dataAsset.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Microsoft.AiForScienceCatalog.Versions)
namespace Microsoft.AiForScienceCatalog;

@doc("A dataAsset version.")
@parentResource(DataAsset)
@resource("versions")
model DataAssetVersion {
  @doc("The dataAsset version name.")
  @visibility("read")
  @key("versionName")
  name: string;

  ...BaseDataAsset;
}

interface DataAssetVersions {
  @doc("Fetch a DataAssetVersion by name.")
  getDataAssetVersion is ResourceRead<DataAssetVersion>;

  //  @doc("Creates a DataAsset.")
  //  createOrReplaceDataAssetVersion is StandardResourceOperations.ResourceCreateOrReplace<DataAssetVersion>;

  @doc("Updates DataAsset.")
  createOrUpdateDataAssetVersion is StandardResourceOperations.ResourceCreateOrUpdate<DataAssetVersion>;

  @doc("List DataAsset resources")
  listDataAssetVersions is ResourceList<DataAssetVersion>;

  @doc("Download Definition.")
  downloadDefinition is Operations.ResourceAction<
    DataAssetVersion,
    {},
    {
      definitionContents: string;
    }
  >;
}
