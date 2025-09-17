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

@versioned(Microsoft.AiForScience.Catalog.Versions)
namespace Microsoft.AiForScience.Catalog;

@doc("Enum for data type")
union DataType {
  /** A string. */
  string: "string",

  /** A double. */
  double: "double", // TODO: float64?

  /** An integer. */
  int: "int", // TODO: int32?

  /** float */
  float: "float", // TODO: float32?

  string,
}

@doc("DataAssetDefinition attributes from definitionContents")
model DataAssetDefinitionAttributes {
  ...BaseAttributesWithDescription;
  ...WithCategory;
  ...WithVersion;
  ...WithLicense;
  ...WithCopilotInstruction;
  ...WithInfraType;
}

@doc("A base dataAsset.")
model BaseDataAssetDefinition {
  ...Artifact<DataAssetDefinitionAttributes>;
}

@doc("A dataAsset.")
@parentResource(Catalog)
@resource("dataAssetDefinitions")
model DataAssetDefinition {
  @doc("The dataAsset name.")
  @visibility("read")
  @key("dataAssetName")
  name: string;

  ...BaseDataAssetDefinition;
}

@doc("A dataAsset.")
@parentResource(Catalog)
@resource("dataAssetDefinitions")
model DataAssetDefinitionWithYaml {
  @doc("The dataAsset name.")
  @visibility("read")
  @key("dataAssetName")
  name: string;

  ...BaseDataAssetDefinition;
  ...WithDefinitionContents;
}

interface DataAssetDefinitions {
  @doc("Fetch a DataAssetDefinition by name.")
  getDataAssetDefinition is ResourceRead<DataAssetDefinition>;

  @doc("Create a DataAssetDefinition.")
  createOrReplaceDataAssetDefinition is StandardResourceOperations.ResourceCreateOrReplace<DataAssetDefinitionWithYaml>;

  @doc("Update DataAssetDefinition.")
  createOrUpdateDataAssetDefinition is StandardResourceOperations.ResourceCreateOrUpdate<DataAssetDefinitionWithYaml>;

  @doc("List DataAssetDefinition resources")
  listDataAssetDefinitions is ResourceList<DataAssetDefinition>;

  @doc("Delete a DataAssetDefinition.")
  deleteDataAssetDefinition is ResourceDelete<DataAssetDefinition>;
}
