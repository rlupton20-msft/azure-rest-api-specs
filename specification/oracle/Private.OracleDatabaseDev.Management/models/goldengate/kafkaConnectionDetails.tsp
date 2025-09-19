import "./connection.tsp";
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Private.OracleDatabaseDev;

// https://docs.oracle.com/en-us/iaas/api/#/en/goldengate/20200407/datatypes/CreateKafkaConnectionDetails

@added(Versions.v20251001_preview)
@doc("Allowed values for Kafka technology type.")
union KafkaConnectionTechnologyType {
  @doc("The Apache Kafka type.")
  ApacheKafka: "APACHE_KAFKA",

  @doc("The Azure Event Hubs type.")
  AzureEventHubs: "AZURE_EVENT_HUBS",

  @doc("The Confluent Kafka type.")
  ConfluentKafka: "CONFLUENT_KAFKA",

  @doc("The OCI Streaming type.")
  OciStreaming: "OCI_STREAMING",

  string,
}

@added(Versions.v20251001_preview)
@doc("The Kafka bootstrap server with host name, and an optional port.")
model KafkaBootstrapServer {
  @doc("The name or address of a host.")
  @minLength(1)
  @maxLength(800)
  host: string;

  @doc("The port of an endpoint usually specified for a connection.")
  @minLength(0)
  @maxLength(65536)
  port?: string;
}

@added(Versions.v20251001_preview)
@doc("The metadata of a Kafka Connection.")
model KafkaConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.Kafka;

  @doc("The Kafka technology type.")
  technologyType: KafkaConnectionTechnologyType;

  @doc("The list of KafkaBootstrapServer objects specified by host/port.")
  @OpenAPI.extension("x-ms-identifiers", #[])
  bootstrapServers?: KafkaBootstrapServer[];
}
