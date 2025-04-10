import "../resourceIds.tsp";

@doc("The destination configuration for the channel resources.")
@discriminator("connectorType")
model ChannelDestinationProperties {
  @doc("The type of destination connector.")
  connectorType: ChannelDestinationConnectorType;
}

@doc("Types of destination connectors supported for the channel resources.")
union ChannelDestinationConnectorType {
  string,

  @doc("Storage Account destination connector.")
  StorageAccountConnector: "StorageAccountConnector",

  @doc("One Lake destination connector.")
  OneLakeConnector: "OneLakeConnector",
}

@doc("StorageAccountConnector destination properties.")
model StorageAccountConnectorDestinationProperties
  extends ChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: ChannelDestinationConnectorType.StorageAccountConnector;

  @doc("The resource ID of an existing storageAccountConnector resource linked/associated to the same hub resource, to use as destination.")
  storageAccountConnectorResourceId: StorageAccountConnectorResourceId;
}

@doc("OneLakeConnector destination properties.")
model OneLakeConnectorDestinationProperties
  extends ChannelDestinationProperties {
  @doc("The type of destination connector to be used for the channel.")
  connectorType: ChannelDestinationConnectorType.OneLakeConnector;

  @doc("The resource ID of an existing oneLakeConnector resource linked/associated to the same hub resource, to use as destination.")
  oneLakeConnectorResourceId: OneLakeConnectorResourceId;
}
