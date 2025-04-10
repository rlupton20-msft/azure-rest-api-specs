import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "./../common/provisioningState.tsp";
import "./../common/resourceIds.tsp";
import "./../common/models/destinationModels.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Private.HealthcareInteropDev;

@doc("The healthcare interop resource that transfers Dicom files.")
@resource("dicomNoOpChannels")
model DicomNoOpChannel
  is TrackedResource<DicomNoOpChannelProperties> {
  @doc("The name of the DicomNoOpChannel resource.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("dicomNoOpChannelName")
  @segment("dicomNoOpChannels")
  @path
  name: string;
}

@doc("The properties to configure the DicomNoOpChannel resource.")
model DicomNoOpChannelProperties {
  @doc("The status of the last provisioning operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningLROState;

  @doc("The resource ID of an existing hub resource to link/associate this dicomNoOpChannel resource to.")
  hubResourceId: HubResourceId;

  @doc("The settings to configure the source of the data to be ingested.")
  sourceConfiguration: DicomNoOpChannelSourceProperties;

  @doc("The settings to configure the destination of the data to be persisted.")
  destinationConfiguration: ChannelDestinationProperties;
}

// #region Source

@doc("The source configuration for the DicomNoOpChannel resource.")
@discriminator("connectorType")
model DicomNoOpChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DicomNoOpChannelSourceConnectorType;
}

@doc("Types of source connectors supported for the DicomNoOpChannel resource.")
union DicomNoOpChannelSourceConnectorType {
  string,

  @doc("Dicom connector.")
  DicomConnector: "DicomConnector",
}

@doc("DicomConnector source properties.")
model DicomConnectorSourceProperties
  extends DicomNoOpChannelSourceProperties {
  @doc("The type of source connector to be used for this channel.")
  connectorType: DicomNoOpChannelSourceConnectorType.DicomConnector;

  @doc("The resource ID of an existing dicomConnector resource linked/associated to the same hub resource, to use as source.")
  dicomConnectorResourceId: DicomConnectorResourceId;
}

// #endregion Source

// #region Destination

// Shared models in ../common/models/destinationModels.tsp

// #endregion Destination

@armResourceOperations
interface DicomNoOpChannels {
  get is ArmResourceRead<DicomNoOpChannel>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DicomNoOpChannel>;
  update is ArmResourcePatchAsync<
    DicomNoOpChannel,
    DicomNoOpChannelProperties
  >;
  delete is ArmResourceDeleteWithoutOkAsync<DicomNoOpChannel>;
  listByResourceGroup is ArmResourceListByParent<DicomNoOpChannel>;
  listBySubscription is ArmListBySubscription<DicomNoOpChannel>;
}
