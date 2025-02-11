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

@doc("Enum for data type")
union DataType {
  /** string */
  string: "string",

  /** double */
  double: "double", // TODO: float64?

  /** int */
  int: "int", // TODO: int32?

  /** float */
  float: "float", // TODO: float32?

  string,
}

@doc("DataAsset attributes from definitionContents")
model DataAssetAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithVersion;
  ...WithLicense;
  ...WithCopilotInstruction;
  ...WithInfraType;
}

@doc("A base dataAsset.")
model BaseDataAsset {
  ...Artifact<DataAssetAttributes>;
}

@doc("A dataAsset.")
@parentResource(Catalog)
@resource("dataAssets")
model DataAsset {
  @doc("The dataAsset name.")
  @visibility("read")
  @key("dataAssetName")
  name: string;

  ...BaseDataAsset;
  //  ...WithDefinitionContents; // TODO: One of these kids is not like the others
}

interface DataAssets {
  @doc("Fetch a DataAsset by name.")
  getDataAsset is ResourceRead<DataAsset>;

  @doc("Create a DataAsset.")
  createOrReplaceDataAsset is StandardResourceOperations.ResourceCreateOrReplace<DataAsset &
    WithDefinitionContents>;

  @doc("Update DataAsset.")
  createOrUpdateDataAsset is StandardResourceOperations.ResourceCreateOrUpdate<DataAsset &
    WithDefinitionContents>;

  @doc("List DataAsset resources")
  listDataAssets is ResourceList<DataAsset>;

  @doc("Delete a DataAsset.")
  deleteDataAsset is ResourceDelete<DataAsset>;
}
