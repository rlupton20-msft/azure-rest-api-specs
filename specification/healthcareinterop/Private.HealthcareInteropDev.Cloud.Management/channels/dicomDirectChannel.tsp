import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop resource that transfers Dicom files.")
@resource("dicomDirectChannels")
model DicomDirectChannel
  is TrackedResource<DicomDirectChannelProperties> {
  @doc("The name of the DicomDirectChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomDirectChannelName")
  @segment("dicomDirectChannels")
  @path
  name: string;
}

@doc("The properties to configure the DicomDirectChannel resource.")
model DicomDirectChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this dicomDirectChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: DicomDirectChannelSourceProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: ChannelDestinationProperties;
}

// #region Source

@doc("The source configuration for the DicomDirectChannel resource.")
@discriminator("connectorType")
model DicomDirectChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DicomDirectChannelSourceConnectorType;
}

@doc("Types of source connectors supported for the DicomDirectChannel resource.")
union DicomDirectChannelSourceConnectorType {
  string,

  @doc("Dicom connector.")
  DicomConnector: "DicomConnector",
}

@doc("DicomConnector source properties.")
model DicomConnectorSourceProperties
  extends DicomDirectChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DicomDirectChannelSourceConnectorType.DicomConnector;

  @doc("The resource ID of an existing dicomConnector resource linked/associated to the same hub resource, to use as source.")
  dicomConnectorResourceId: DicomConnectorResourceId;
}

// #endregion Source

// #region Destination

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

// #endregion Destination

@armResourceOperations
interface DicomDirectChannels {
  get is ArmResourceRead<DicomDirectChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomDirectChannel>;
  update is ArmResourcePatchAsync<
    DicomDirectChannel,
    DicomDirectChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DicomDirectChannel>;
  listByResourceGroup is ArmResourceListByParent<DicomDirectChannel>;
  listBySubscription is ArmListBySubscription<DicomDirectChannel>;
}
