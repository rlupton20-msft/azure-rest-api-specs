import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Autorest;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Search;

@doc("An indexer resource is a child tracked resource of index")
@parentResource(Index)
model Indexer is TrackedResource<IndexerProperties>{
  @path
  @key("indexerName")
  @segment("indexers")
  @visibility("read")
  @doc("The name of the indexer resource")
  name: string;
}

@armResourceOperations
interface IndexerOperations{
  get is ArmResourceRead<Indexer>;
  list is ArmResourceListByParent<Indexer>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Indexer>;
  update is ArmResourcePatchAsync<Indexer, IndexerProperties>;
  delete is ArmResourceDeleteAsync<Indexer>;
}

@doc("The properties of the indexer")
model IndexerProperties {
  @doc("The description of the indexer resource")
  description?: string;

  @visibility("read")
  @doc("The current provisioning state of the indexer")
  provisioningState?: ProvisioningState;

  @doc("The failure policy")
  failurePolicy: FailurePolicy;

  @doc("Connection and container information for DataSource")
  dataSource: DataSource;
}

@doc("datasource object")
model DataSource {
  @doc("Data source Connection definition")
  connection: Connection;
  
  @doc("other datasource Properties")
  properties: DataSourceProperties;
}

@discriminator("authenticationType")
@doc("Parent connection")
model Connection {}

@doc("Credentials definition")
model Credentials extends Connection {
  @doc("Connection type")
  authenticationType: "Credentials";

  @doc("Connection string")
  @secret
  connectionString: string;
}

@discriminator("kind")
@doc("Datasource properties types")
model DataSourceProperties {}

@doc("CosmosDb/NoSql Datasource")
model CosmosDbNoSql extends DataSourceProperties {
  @doc("CosmosDb datasource type")
  kind: "CosmosDb/NoSql";

  @doc("CosmosDB/NoSql Database name")
  collectionName: string;

  @doc("Query information")
  query: string;
}

@doc("Sql/AzureSql Datasource")
model AzureSql extends DataSourceProperties {
  @doc("Sql/AzureSql datasource type")
  kind: "Sql/AzureSql";

  @doc("Sql/AzureSql Database name")
  tableOrViewName: string;
}

@doc("Storage Blob Datasource")
model AzureStorageBlob extends DataSourceProperties {
  @doc("AzureStorage Blob datasource type")
  kind: "Storage/AzureBlob";

  @doc("Azure Blob container name")
  containerName: string;
  
  @doc("Query information")
  query: string;
}

@doc("AzureStorage Table Datasource")
model AzureStorageTable extends DataSourceProperties {
  @doc("AzureStorage Table datasource type")
  kind: "Storage/AzureTable";

  @doc("Azure Table container name")
  containerName: string;
  
  @doc("Query information")
  query: string;
}

@doc("Failure policy parent")
model FailurePolicy {
  @doc("Failure policy type")
  type: FailurePolicyType;
}

@doc("Supported Failure policy")
enum FailurePolicyType {
  @doc("Indexer will stop after the first failure")
  FailOnFirstFailure,
  @doc("Indexer will not stop for the specified number of failures")
  TolerateFailures
}